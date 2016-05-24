# polyline

Haxe implementation of [Google's polyline algorithm](https://developers.google.com/maps/documentation/utilities/polylinealgorithm)


## Usage

```haxe
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

var encoded = Polyline.encode(example);
var decoded = Polyline.decode(encoded);
```