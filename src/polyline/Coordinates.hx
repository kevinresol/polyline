package polyline;

#if geojson
typedef Coordinates = geojson.util.Coordinates;

#else

abstract Coordinates(Array<Float>) to Array<Float> {
	
	public var latitude(get, set):Float;
	public var longitude(get, set):Float;
	
	public inline function new(latitude:Float, longitude:Float)
		this = [longitude, latitude];
		
	inline function get_latitude() return this[1];
	inline function get_longitude() return this[0];
	inline function set_latitude(v) return this[1] = v;
	inline function set_longitude(v) return this[0] = v;
}

#end