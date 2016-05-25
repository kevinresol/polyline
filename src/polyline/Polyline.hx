package polyline;

class Polyline {
	
	public static function encode(coordinates:Array<Coordinates>, precision = 5):String {
		if(coordinates == null || coordinates.length == 0) return '';
		var factor = Math.pow(10, precision);
		var output = new StringBuf();
		
		function encodeValue(value:Float) {
			var v = Math.round(value * factor);
			v <<= 1;
			if(value < 0) v = ~v;
			
			while(v >= 0x20) {
				output.add(String.fromCharCode((0x20 | (v & 0x1f)) + 63));
				v >>= 5;
			}
			output.add(String.fromCharCode(v + 63));
		}
		
		encodeValue(coordinates[0].latitude);
		encodeValue(coordinates[0].longitude);
		for(i in 1...coordinates.length) {
			var current = coordinates[i];
			var prev = coordinates[i - 1];
			encodeValue(current.latitude - prev.latitude);
			encodeValue(current.longitude - prev.longitude);
		}
		return output.toString();
	}
	
	public static function decode(str:String, precision = 5):Array<Coordinates> {
		var factor = Math.pow(10, precision);
		var pos = 0;
		
		function decodeValue(log=false) {
			var result = 0;
			var shift = 0;
			var byte = 0;
			do {
				byte = str.charCodeAt(pos++) - 63;
				result |= (byte & 0x1f) << shift;
				shift += 5;
			} while (byte >= 0x20);
			
			return (result & 1) != 0 ? ~(result >>1) : (result >> 1);
		}
	
		var lat = 0;
		var long = 0;
		var result = [];
		
		while(pos < str.length) {
			lat += decodeValue(true);
			long += decodeValue();
			result.push({latitude: lat / factor, longitude: long / factor});
		}
		
		return result;
	}
}

typedef Coordinates = {
	latitude:Float,
	longitude:Float,
}