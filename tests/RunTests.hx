package;

import haxe.unit.TestCase;
import haxe.unit.TestRunner;
import polyline.Polyline.*;
import polyline.Polyline;

class RunTests extends TestCase {
	
	var example = [{
		latitude: 38.5,
		longitude: -120.2
	},{
		latitude: 40.7,
		longitude: -120.95
	},{
		latitude: 43.252,
		longitude: -126.453
	}];
	
	var exampleSlashes = [{
		latitude: 35.6,
		longitude: -82.55
	},{
		latitude: 35.59985,
		longitude: -82.55015
	},{
		latitude: 35.6,
		longitude: -82.55
	}];
	
	static function main() {
		var t = new TestRunner();
		t.add(new RunTests());
		if(!t.run()) {
			#if sys Sys.exit(500); #end
		}
	}
	
	function testEncode() {
		assertEquals('', encode(null));
		assertEquals('', encode([]));
		assertEquals('_p~iF~ps|U_ulLnnqC_mqNvxq`@', encode(example));
		assertEquals('_izlhA~rlgdF_{geC~ywl@_kwzCn`{nI', encode(example, 6));
	}
	
	function testDecode() {
		assertCoordinates([], decode(''));
		assertCoordinates(example, decode('_p~iF~ps|U_ulLnnqC_mqNvxq`@'));
		assertCoordinates(example, decode('_izlhA~rlgdF_{geC~ywl@_kwzCn`{nI', 6));
	}
	
	function testRoundTip() {
		assertCoordinates(example, decode(encode(example)));
		assertCoordinates(example, decode(encode(example, 6), 6));
		assertCoordinates(exampleSlashes, decode(encode(exampleSlashes)));
		assertCoordinates(exampleSlashes, decode(encode(exampleSlashes, 6), 6));
		assertEquals('_chxEn`zvN\\\\]]', encode(decode('_chxEn`zvN\\\\]]')));
		assertTrue(decode(encode([{latitude:-107.3741825, longitude:0}], 7), 7)[0].latitude < 0);
	}
	
	function assertCoordinates(expected:Array<Coordinate>, actual:Array<Coordinate>) {
		assertEquals(expected.length, actual.length);
		for(i in 0...expected.length) {
			assertEquals(expected[i].latitude, actual[i].latitude);
			assertEquals(expected[i].longitude, actual[i].longitude);
		}
	}
}