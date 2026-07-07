#version 320 es
precision mediump float;

uniform sampler2D uTexture;  // The window texture
in vec2 vTexCoord;           // Texture coordinate from vertex shader
out vec4 fragColor;

// Adjustable parameters:
const float BLUR_RADIUS = 5.0;   // Size of blur kernel in “pixels” (adjust as needed)
const float KEY_THRESHOLD = 0.1; // If the color’s brightness is below this, treat as background

// A simple (naive) box blur function:
vec4 applyBlur(vec2 uv) {
    vec4 sum = vec4(0.0);
    float total = 0.0;
    
    // Ensure loops have constant limits for ES 3.2 compatibility
    for (int x = -int(BLUR_RADIUS); x <= int(BLUR_RADIUS); x++) {
        for (int y = -int(BLUR_RADIUS); y <= int(BLUR_RADIUS); y++) {
            vec2 offset = vec2(float(x), float(y)) / vec2(1920.0, 1080.0); // Adjust resolution
            vec4 colSample = texture(uTexture, uv + offset);
            sum += colSample;
            total += 1.0;
        }
    }
    return sum / total;
}

void main() {
    vec4 color = texture(uTexture, vTexCoord);
    float brightness = (color.r + color.g + color.b) / 3.0;

    // Apply blur only to nearly black areas (background)
    if (brightness < KEY_THRESHOLD) {
        fragColor = applyBlur(vTexCoord);
    } else {
        fragColor = color;
    }
}

