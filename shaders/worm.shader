#elif COMPILING_FRAGMENT_PROGRAM

    void frag(){
        vec4 screencoords = gl_FragCoord;

        screencoords.x /= screensize.x;
        screencoords.y /= screensize.y;
        
        // Flip the screen upside down
        screencoords.y = 1.0 - screencoords.y;

        float scale_x = screensize.x / 1.0;
        float scale_y = screensize.y / 1.0;
        float scale_min = min(scale_x, scale_y);

        vec2 ratio = vec2(scale_min / scale_x, scale_min / scale_y);

        // Note: worldPos.y might look inverted relative to the visual screen since coordinates are flipped
        vec2 rippleval = vec2(sin(-timer*0*.5+worldPos.y / 9.0) * .0007*3.0 * ratio.x, 0.0);
        rippleval += vec2(sin(-timer*0*.5+worldPos.y / 16.0) * .0005*3.0 * ratio.x, 0.0);
        rippleval += vec2(sin(-timer*0*0+worldPos.x / 32.0) * .0006*3.0 * ratio.x, 0.0);
        
        vec4 basecolor = texture(framebuf, screencoords.xy + rippleval);

        vec4 outcolor = basecolor;

        outcolor = outcolor*(1.0-gl_Color.a) + gl_Color*gl_Color.a;

        outcolor.a = 1.0;
        gl_FragColor = outcolor;
    }
