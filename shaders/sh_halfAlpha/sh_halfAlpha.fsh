varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float Position;

void main()
{
    //vec4 Colour = texture2D( gm_BaseTexture, v_vTexcoord ); // get colour of pixel
    // add brightness to pixel that depends on Position uniform
    //Colour.r += Position; // for red channel
	//Colour.r = Position;
    //Colour.g += Position; // for green channel
    //Colour.b += Position; // for blue channel
	vec4 c = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor = vec4(c.rgb, c.a * .25);
}
