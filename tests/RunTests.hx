package;

import haxe.unit.TestCase;
import haxe.unit.TestRunner;
import polyline.Polyline.*;
import polyline.Coordinates;

#if flash
import flash.system.System.exit;
#else
import Sys.exit;
#end

class RunTests extends TestCase {
	
	var example = [
		new Coordinates(38.5, -120.2),
		new Coordinates(40.7, -120.95),
		new Coordinates(43.252, -126.453),
	];
	
	var exampleSlashes = [
		new Coordinates(35.6, -82.55),
		new Coordinates(35.59985, -82.55015),
		new Coordinates(35.6, -82.55),
	];
	
	static function main() {
		var t = new TestRunner();
		t.add(new RunTests());
		exit(t.run() ? 0 : 500);
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
		assertTrue(decode(encode([new Coordinates(-107.3741825, 0)], 7), 7)[0].latitude < 0);
	}
	
	function assertCoordinates(expected:Array<Coordinates>, actual:Array<Coordinates>) {
		assertEquals(expected.length, actual.length);
		for(i in 0...expected.length) {
			assertEquals(expected[i].latitude, actual[i].latitude);
			assertEquals(expected[i].longitude, actual[i].longitude);
		}
	}
}