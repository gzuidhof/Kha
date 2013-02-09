package kha.graphics;

class VertexStructure {
	public var elements: Array<VertexElement>;
	
	public function new() {
		elements = new Array<VertexElement>();
	}
	
	public function add(name: String, data: VertexData, type: VertexType) {
		elements.push(new VertexElement(name, data, type));
	}
}