#version 410

layout(location = 0) in vec3 inPos;
layout(location = 1) in vec3 inColor;
layout(location = 2) in vec3 inNormal;

uniform vec3 LightPos;
uniform bool blinn;
out vec4 frag_color;


void main() {
	
	// Lecture 5
	vec3 lightColor = vec3(1.0, 1.0, 1.0);

	// Ambient
	float ambientStrength = 0.15;
	vec3 ambient = ambientStrength * lightColor * inColor;

	// Diffuse
	vec3 N = normalize(inNormal);
	vec3 lightDir = normalize(LightPos - inPos);
	float dif = max(dot(N, lightDir), 0.0);
	vec3 diffuse = dif * inColor; 

	//Attenuation
	float dist = length(LightPos - inPos);
	diffuse = diffuse / dist;



	// Specular
	vec3 camPos = vec3(0.0, 0.0, 3.0);//Pass this as a uniform from your C++ code
	float specStr = 1.0; // this can be a uniform
	vec3 camDir = normalize(camPos - inPos);
	vec3 halfDir = normalize(lightDir + camDir);
	vec3 reflectDir = reflect(-lightDir, N);


	float spec = pow(max(dot(N, halfDir), 0.0), 128); // Shininess coefficient (can be a uniform)
	//float spec = pow(max(dot(camDir, reflectDir), 0.0), 128);
	vec3 specular = specStr * spec * lightColor; // Can also use a specular colour
	vec3 result = (ambient + diffuse + specular);
	frag_color = vec4(result, 1.0);





}