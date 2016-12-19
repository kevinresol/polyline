# polyline [![Build Status](https://travis-ci.org/kevinresol/polyline.svg?branch=master)](https://travis-ci.org/kevinresol/polyline)

Haxe implementation of [Google's polyline algorithm](https://developers.google.com/maps/documentation/utilities/polylinealgorithm)

Ported from https://github.com/mapbox/polyline

## Usage

```haxe
var example = [
	new Coordinates(38.5, -120.2),
	new Coordinates(40.7, -120.95),
	new Coordinates(43.252, -126.453),
];

var encoded = Polyline.encode(example);
var decoded = Polyline.decode(encoded);
```
