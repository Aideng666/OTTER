#pragma once
#include <vector>
#include <string>
#include <GLM/glm.hpp>

class ObjLoader
{
public:

	//Reads a obj text file and loads in and creates an Obj in main.cpp based on vertices, uvs, normals, and faces
	static bool LoadFromFile(const std::string& filename, std::vector<glm::vec3> &outV, std::vector<glm::vec2> &outUV, std::vector<glm::vec3> &outN);

protected:

	//Default constructor and destructor
	ObjLoader() = default;
	~ObjLoader() = default;
};
