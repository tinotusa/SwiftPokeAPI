//
//  File.swift
//  
//
//  Created by Tino on 1/10/2022.
//

import Foundation
import os

/// The cache for PokeAPI.
public final class Cache<Key, Value> where Key: Hashable {
    /// The max number of objects the cache should hold.
    public var countLimit = 0
    
    /// The actual cache.
    private var cache = NSCache<WrappedKey, CacheEntry>()
    /// An object to track the keys the cache has.
    private var keyTracker = KeyTracker()
    /// An object to log the state of the cache.
    private let logger = Logger(subsystem: "com.tinotusa.SwiftPokeAPI", category: "Cache")
    
    /// Creates a cache using the specified count limit.
    /// - parameter countLimit: The maximum number of objects the cache should hold.
    init(countLimit: Int = 0) {
        cache.countLimit = countLimit
        cache.delegate = keyTracker
    }
    
    /// The keys of the cache.
    var keys: Set<Key> {
        keyTracker.keys
    }
}

// MARK: Wrapper classes
public extension Cache {
    /// A key wrapper for NSCache.
    final class WrappedKey: NSObject {
        private let key: Key
        
        init(_ key: Key) {
            self.key = key
        }
        
        public override var hash: Int { return key.hashValue }
        
        public override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? Self else {
                return false
            }
            return value.key == key
        }
    }
    
    /// A cache entry wrapper for NSCache.
    final class CacheEntry {
        let key: Key
        let value: Value
        
        init(key: Key, value: Value) {
            self.key = key
            self.value = value
        }
    }
    
    /// The NSCache delegate.
    final class KeyTracker: NSObject, NSCacheDelegate {
        /// The keys in the NSCache.
        private(set) var keys: Set<Key> = []
        
        public func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
            guard let cacheEntry = obj as? CacheEntry else {
                return
            }
            keys.remove(cacheEntry.key)
        }
        
        /// Inserts a key in to the set.
        /// -  parameter key: The key to be inserted.
        func insert(_ key: Key) {
            self.keys.insert(key)
        }
    }
}

// MARK: Functions
public extension Cache {
    /// Returns the value for the given key.
    /// - parameter key: The key for the value.
    func value(forKey key: Key) -> Value? {
        logger.debug("Getting data for key: \(key.hashValue)")
        
        let entry = cache.object(forKey: WrappedKey(key))
        if entry != nil {
            logger.debug("Successfully got data for key: \(key.hashValue).")
        } else {
            logger.debug("Failed to get data for key: \(key.hashValue).")
        }
        return entry?.value
    }
    
    /// Inserts a value into the cache using the given key.
    /// - parameter value: The value to be inserted.
    /// - parameter key: The key associated with the value.
    func insert(_ value: Value, forKey key: Key) {
        logger.debug("Setting data in cache for key \(key.hashValue).")
        
        let entry = CacheEntry(key: key, value: value)
        cache.setObject(entry, forKey: WrappedKey(key))
        keyTracker.insert(key)
        
        logger.debug("Successfully set data in cache for key \(key.hashValue).")
    }
    
    /// Returns a CacheEntry for the given key.
    /// - parameter key: The key for the CacheEntry.
    /// - returns: A CacheEntry if one is found or nil.
    func cacheEntry(forKey key: Key) -> CacheEntry? {
        guard let cacheEntry = cache.object(forKey: WrappedKey(key)) else {
            return nil
        }
        return cacheEntry
    }
    /// Inserts the CacheEntry into the cache.
    /// - parameter entry: The entry to be inserted.
    func insert(_ entry: CacheEntry) {
        cache.setObject(entry, forKey: WrappedKey(entry.key))
        keyTracker.insert(entry.key)
    }
    
    /// Removes a value from the cache.
    /// - parameter key: The key of the value to be removed.
    func remove(forKey key: Key) {
        logger.debug("Removing data in cache for key \(key.hashValue).")
        cache.removeObject(forKey: WrappedKey(key))
        logger.debug("Successfully remoed data in cache for key \(key.hashValue).")
    }
    
    /// Returns the size of the cache file on disk.
    /// - parameter filename: The name of the cache on disk.
    /// - parameter fileManager: The file manager object to be used to find the cache file.
    /// - returns: The size of the file in bytes.
    func size(filename: String, fileManager: FileManager = .default) throws -> UInt64 {
        logger.debug("Starting to get cache file size")
        let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let cacheURL = cachesDirectory.appending(path: filename)
        if !fileManager.fileExists(atPath: cacheURL.path()) {
            logger.error("Failed to get cache file size. The file \(filename) doesn't exist.)")
            throw CacheError.fileDoesNotExist(filename: filename)
        }
        do {
            let attributes = try fileManager.attributesOfItem(atPath: cacheURL.path())
            if let size = attributes[.size] as? UInt64 {
                logger.debug("Successfully got cache file size: \(size.formatted(.byteCount(style: .file)))")
                return size
            }
            return 0
        } catch {
            logger.error("Failed to get cache file size. \(error)")
            throw error
        }
    }
    
    /// Clears the cache in memory.
    ///
    /// This doesn't delete the cache file on disk.
    /// Call `deleteCacheFromDisk(filename: fileManager:)` to delete the file.
    func clearCache() {
        logger.debug("Clearing the cache.")
        cache.removeAllObjects()
    }
}

// MARK: Subscript
public extension Cache {
    /// Returns the value for the given key.
    ///
    ///     cache["something"] = nil // This removes "something" from the cache.
    ///
    /// If a nil value is added to the set it removes the value and the key
    /// - parameter key: The key associated with the value
    subscript(key: Key) -> Value? {
        get { value(forKey: key) }
        set {
            guard let value = newValue else {
                remove(forKey: key)
                return
            }
            insert(value, forKey: key)
        }
    }
}

// MARK: Cache entry codable conformance
extension Cache.CacheEntry: Codable where Key: Codable, Value: Codable {
    
}

// MARK: Codable conformance
extension Cache: Codable where Key: Codable, Value: Codable {
    public convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.singleValueContainer()
        let entries = try container.decode([CacheEntry].self)
        entries.forEach(insert)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(keyTracker.keys.compactMap(cacheEntry))
    }
    
    /// Loads the cache from a file on disk.
    ///
    /// This will set the current caches data to the data loaded from disk.
    ///
    /// - parameter filename: The name of the file on disk.
    /// - parameter fileManager: The file manager to use.
    func loadCacheFromDisk(filename: String, fileManager: FileManager = .default) throws {
        logger.debug("Loading cache from disk.")
        let filename = filterFilename(filename: filename)
        if filename.isEmpty {
            throw PokeAPIError.invalidFilename
        }
        let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = cachesDirectory.appending(path: filename)
        
        do {
            if !fileManager.fileExists(atPath: fileURL.path()) {
                throw CacheError.fileDoesNotExist(filename: filename)
            }
            let data = try Data(contentsOf: fileURL)
            let decodedData = try JSONDecoder().decode(Self.self, from: data)
            
            cache = decodedData.cache
            keyTracker = decodedData.keyTracker
            countLimit = decodedData.countLimit
            
            logger.debug("Successfully loaded cache named: \(filename) from disk.")
        } catch {
            logger.error("Failed to load cache from disk. \(error)")
            throw error
        }
    }
    
    /// Filters a string by removing invalid characters.
    /// - parameter filename: The name of the file to filter.
    /// - returns: The filtered string.
    private func filterFilename(filename: String) -> String {
        var invalidCharacters = CharacterSet(charactersIn: ":/")
        invalidCharacters.formUnion(.newlines)
        invalidCharacters.formUnion(.illegalCharacters)
        invalidCharacters.formUnion(.controlCharacters)
        
        return filename
            .components(separatedBy: invalidCharacters)
            .joined(separator: "")
    }
    
    /// Saves the cache to disk.
    /// - parameter filename: The name of the save file.
    /// - parameter fileManager: The file manager to use to save.
    func saveCacheToDisk(withName filename: String, fileManager: FileManager = .default) throws {
        logger.debug("Saving cache to disk with file name: \(filename).")
        let filename = filterFilename(filename: filename)
        if filename.isEmpty {
            throw PokeAPIError.invalidFilename
        }
        
        let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = cachesDirectory.appending(path: filename)
        
        do {
            let data = try JSONEncoder().encode(self)
            try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
            logger.debug("Successfully saved cache with name: \(filename) to disk.")
            
        } catch let error as EncodingError {
            logger.error("Failed to encode cache.")
            throw CacheError.encodingError(error: error)
            
        } catch {
            logger.debug("Failed to save cache to disk with file name: \(filename). \(error)")
            throw error
        }
    }
    
    /// Deletes the cache file on disk.
    /// - parameter filename: The name of the file to delete.
    /// - parameter fileManager: The file manager to use.
    func deleteCacheFromDisk(filename: String, fileManager: FileManager = .default) throws {
        logger.debug("Deleting cache named: \(filename) from disk.")
        
        let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = cachesDirectory.appending(path: filename)
        do {
            if !fileManager.fileExists(atPath: fileURL.path()) {
                logger.error("Failed to remove file name: \(filename). File doesn't exist.")
                throw CacheError.fileDoesNotExist(filename: filename)
            }
            try fileManager.removeItem(at: fileURL)
            logger.debug("Successfully deleted cache named \(filename) from disk.")
        } catch {
            logger.error("Failed to remove file name: \(filename). \(error)")
            throw error
        }
    }
}
