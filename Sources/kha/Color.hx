package kha;

@:expose
abstract Color(Int) {
	public static var Black: Color = fromValue(0xff000000);
	public static var White: Color = fromValue(0xffffffff);
	
	/**
		Creates a new Color object from a packed 32 bit ARGB value.
	**/
	public static inline function fromValue(value: Int): Color {
		return new Color(value);
	}
	
	/**
		Creates a new Color object from components in the range 0 - 255.
	**/
	public static function fromBytes(r: Int, g: Int, b: Int, a: Int = 255): Color {
		return new Color((a << 24) | (r << 16) | (g << 8) | b);
	}
	
	/**
		Creates a new Color object from components in the range 0 - 1.
	**/
	public static function fromFloats(r: Float, g: Float, b: Float, a: Float = 1): Color {
		return new Color((Std.int(a * 255) << 24) | (Std.int(r * 255) << 16) | (Std.int(g * 255) << 8) | Std.int(b * 255));
	}
	
	/**
		Creates a new Color object from #AARRGGBB string.
	**/
	public static function fromString(value: String) {
		if ((value.length == 7 || value.length == 9) && StringTools.fastCodeAt(value, 0) == "#".code) {
			var colorValue = Std.parseInt("0x" + value.substr(1));
			if (value.length == 7) {
				colorValue += 0xFF000000;
			}
			return fromValue(colorValue);
		}
		else {
			throw "Invalid Color string: '" + value + "'";
		}
	}
	
	/**
		Contains a byte representing the red color component.
	**/
	public var Rb(get, set): Int;
	
	/**
		Contains a byte representing the green color component.
	**/
	public var Gb(get, set): Int;
	
	/**
		Contains a byte representing the blue color component.
	**/
	public var Bb(get, set): Int;
	
	/**
		Contains a byte representing the alpha color component (more exactly the opacity component - a value of 0 is fully transparent).
	**/
	public var Ab(get, set): Int;
	
	public var R(get, set): Float;
	public var G(get, set): Float;
	public var B(get, set): Float;
	public var A(get, set): Float;
	
	private function new(value: Int) {
		this = value;
	}
	
	public var value(get, set): Int;
	
	private inline function get_value(): Int {
		return this;
	}
	
	private inline function set_value(value: Int): Int {
		this = value;
		return this;
	}

	private function get_Rb(): Int {
		return (this & 0x00ff0000) >>> 16;
	}
	
	private function get_Gb(): Int {
		return (this & 0x0000ff00) >>> 8;
	}
	
	private function get_Bb(): Int {
		return this & 0x000000ff;
	}
	
	private function get_Ab(): Int {
		return this >>> 24;
	}

	private inline function set_Rb(i: Int): Int {
		this = (Ab << 24) | (i << 16) | (Gb << 8) | Bb;
		return i;
	}
	
	private inline function set_Gb(i: Int): Int {
		this = (Ab << 24) | (Rb << 16) | (i << 8) | Bb;
		return i;
	}
	
	private inline function set_Bb(i: Int): Int {
		this = (Ab << 24) | (Rb << 16) | (Gb << 8) | i;
		return i;
	}
	
	private inline function set_Ab(i: Int): Int {
		this = (i << 24) | (Rb << 16) | (Gb << 8) | Bb;
		return i;
	}

	private inline function get_R(): Float {
		return get_Rb() / 255;
	}
	
	private inline function get_G(): Float {
		return get_Gb() / 255;
	}
	
	private inline function get_B(): Float {
		return get_Bb() / 255;
	}
	
	private inline function get_A(): Float {
		return get_Ab() / 255;
	}

	private inline function set_R(f: Float): Float {
		this = (Std.int(A * 255) << 24) | (Std.int(f * 255) << 16) | (Std.int(G * 255) << 8) | Std.int(B * 255);
		return f;
	}

	private inline function set_G(f: Float): Float {
		this = (Std.int(A * 255) << 24) | (Std.int(R * 255) << 16) | (Std.int(f * 255) << 8) | Std.int(B * 255);
		return f;
	}

	private inline function set_B(f: Float): Float {
		this = (Std.int(A * 255) << 24) | (Std.int(R * 255) << 16) | (Std.int(G * 255) << 8) | Std.int(f * 255);
		return f;
	}

	private inline function set_A(f: Float): Float {
		this = (Std.int(f * 255) << 24) | (Std.int(R * 255) << 16) | (Std.int(G * 255) << 8) | Std.int(B * 255);
		return f;
	}
}
