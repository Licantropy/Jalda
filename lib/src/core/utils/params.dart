/// A mixin that provides a structure for converting objects to data maps.
/// 
/// This mixin can be used with classes that need to be serialized into a 
/// format suitable for data transmission, such as JSON.
mixin Params {

  /// Converts an instance of the implementing class to a map.
  /// 
  /// This method should provide a key-value representation of the object's
  /// properties, where keys are property names in `String` format, and values 
  /// are the corresponding values of these properties.
  /// 
  /// Returns:
  ///   A `Map<String, dynamic>` representing the object's data.
  Map<String, dynamic> toData();
}
