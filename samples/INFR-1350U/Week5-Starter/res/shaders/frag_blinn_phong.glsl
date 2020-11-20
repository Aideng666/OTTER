#version 410

layout(location = 0) in vec3 inPos;
layout(location = 1) in vec3 inColor;
layout(location = 2) in vec3 inNormal;

uniform vec3  u_AmbientCol;
uniform float u_AmbientStrength;

uniform vec3  u_LightPos;
uniform vec3  u_LightCol;
uniform float u_AmbientLightStrength;
uniform float u_SpecularLightStrength;
uniform float u_Shininess;

uniform vec3  u_CamPos;

out vec4 frag_color;

const float lightIntensity = 10.0;

const int bands = 5;
const float scaleFactor = 1.0 / bands;

// https://learnopengl.com/Advanced-Lighting/Advanced-Lighting
void main() {
	// Lecture 5
	vec3 ambient = ((u_AmbientLightStrength * u_LightCol) + (u_AmbientCol * u_AmbientStrength));

	// Diffuse
	vec3 N = normalize(inNormal);
	vec3 V = normalize(u_CamPos - inPos);
	vec3 lightDir = normalize(u_LightPos - inPos);

	float dif = max(dot(N, lightDir), 0.0);
	vec3 diffuse = dif * u_LightCol;// add diffuse intensity

	//Attenuation
	float dist = length(u_LightPos - inPos);
	diffuse = diffuse / dist; // (dist*dist)
	
	vec3 diffuseOut = (diffuse * inColor) / (dist*dist);
    
    diffuseOut = diffuseOut*lightIntensity;

    //Lecture 10c
    diffuseOut = floor(diffuseOut * bands) * scaleFactor;


	float edge = (dot(V, inNormal) < 0.4) ? 0.0 : 1.0;

	// Specular
	vec3 viewDir = normalize(u_CamPos - inPos);
    vec3 h         = normalize(lightDir + viewDir);
    float spec = pow(max(dot(N, h), 0.0), u_Shininess); // Shininess coefficient (can be a uniform)
	// END OF REPLACE SECTION

	vec3 specular = u_SpecularLightStrength * spec * u_LightCol; // Can also use a specular color

	vec3 result = diffuseOut * edge;
	//vec3 result = (ambient + diffuse + specular) * (1.0, 1.0, 1.0);

	frag_color = vec4(result, 1.0);
}