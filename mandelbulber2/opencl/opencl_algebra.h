/**
 * Mandelbulber v2, a 3D fractal generator       ,=#MKNmMMKmmßMNWy,
 *                                             ,B" ]L,,p%%%,,,§;, "K
 * Copyright (C) 2017 Mandelbulber Team        §R-==%w["'~5]m%=L.=~5N
 *                                        ,=mm=§M ]=4 yJKA"/-Nsaj  "Bw,==,,
 * This file is part of Mandelbulber.    §R.r= jw",M  Km .mM  FW ",§=ß., ,TN
 *                                     ,4R =%["w[N=7]J '"5=],""]]M,w,-; T=]M
 * Mandelbulber is free software:     §R.ß~-Q/M=,=5"v"]=Qf,'§"M= =,M.§ Rz]M"Kw
 * you can redistribute it and/or     §w "xDY.J ' -"m=====WeC=\ ""%""y=%"]"" §
 * modify it under the terms of the    "§M=M =D=4"N #"%==A%p M§ M6  R' #"=~.4M
 * GNU General Public License as        §W =, ][T"]C  §  § '§ e===~ U  !§[Z ]N
 * published by the                    4M",,Jm=,"=e~  §  §  j]]""N  BmM"py=ßM
 * Free Software Foundation,          ]§ T,M=& 'YmMMpM9MMM%=w=,,=MT]M m§;'§,
 * either version 3 of the License,    TWw [.j"5=~N[=§%=%W,T ]R,"=="Y[LFT ]N
 * or (at your option)                   TW=,-#"%=;[  =Q:["V""  ],,M.m == ]N
 * any later version.                      J§"mr"] ,=,," =="""J]= M"M"]==ß"
 *                                          §= "=C=4 §"eM "=B:m|4"]#F,§~
 * Mandelbulber is distributed in            "9w=,,]w em%wJ '"~" ,=,,ß"
 * the hope that it will be useful,                 . "K=  ,=RMMMßM"""
 * but WITHOUT ANY WARRANTY;                            .'''
 * without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with Mandelbulber. If not, see <http://www.gnu.org/licenses/>.
 *
 * ###########################################################################
 *
 * Authors: Krzysztof Marczak (buddhi1980@gmail.com), Sebastian Jennen (jenzebas@gmail.com)
 *
 * mathematical algebra code for opencl
 */

#ifndef MANDELBULBER2_OPENCL_ALGEBRA_HPP_
#define MANDELBULBER2_OPENCL_ALGEBRA_HPP_

#ifndef OPENCL_KERNEL_CODE
#include <QString>
#include "../src/algebra.hpp"
#include "../src/color_structures.hpp"
#endif

typedef struct
{
	cl_float3 m1;
	cl_float3 m2;
	cl_float3 m3;
} matrix33;

#ifndef OPENCL_KERNEL_CODE
inline matrix33 toClMatrix33(CRotationMatrix source)
{
	CMatrix33 matrix = source.GetMatrix();
	matrix33 m;
	m.m1 = {{cl_float(matrix.m11), cl_float(matrix.m12), cl_float(matrix.m13), cl_float(0.0)}};
	m.m2 = {{cl_float(matrix.m21), cl_float(matrix.m22), cl_float(matrix.m23), cl_float(0.0)}};
	m.m3 = {{cl_float(matrix.m31), cl_float(matrix.m32), cl_float(matrix.m33), cl_float(0.0)}};
	return m;
}
inline cl_float3 toClFloat3(CVector3 v)
{
	cl_float3 retVal = {{cl_float(v.x), cl_float(v.y), cl_float(v.z), cl_float(0.0)}};
	return retVal;
}
inline cl_int3 toClInt3(sRGB c)
{
	cl_int3 retVal = {{cl_int(c.R), cl_int(c.G), cl_int(c.B), cl_int(1)}};
	return retVal;
}
inline cl_float3 toClFloat3(sRGB c)
{
	cl_float3 retVal = {
		{cl_float(c.R / 65536.0f), cl_float(c.G / 65536.0f), cl_float(c.B / 65536.0f), cl_float(1.0f)}};
	return retVal;
}
inline cl_float4 toClFloat4(CVector4 v)
{
	cl_float4 retVal = {{cl_float(v.x), cl_float(v.y), cl_float(v.z), cl_float(v.w)}};
	return retVal;
}
#endif

#ifdef OPENCL_KERNEL_CODE

inline float4 Matrix33MulFloat4(matrix33 matrix, float4 vect)
{
	float4 out;
	out.x = dot(vect.xyz, matrix.m1);
	out.y = dot(vect.xyz, matrix.m2);
	out.z = dot(vect.xyz, matrix.m3);
	out.w = vect.w;
	return out;
}

inline float3 Matrix33MulFloat3(matrix33 matrix, float3 vect)
{
	float3 out;
	out.x = dot(vect.xyz, matrix.m1);
	out.y = dot(vect.xyz, matrix.m2);
	out.z = dot(vect.xyz, matrix.m3);
	return out;
}

matrix33 Matrix33MulMatrix33(matrix33 m1, matrix33 m2)
{
	matrix33 out;
	out.m1.x = m1.m1.x * m2.m1.x + m1.m1.y * m2.m2.x + m1.m1.z * m2.m3.x;
	out.m1.y = m1.m1.x * m2.m1.y + m1.m1.y * m2.m2.y + m1.m1.z * m2.m3.y;
	out.m1.z = m1.m1.x * m2.m1.z + m1.m1.y * m2.m2.z + m1.m1.z * m2.m3.z;
	out.m2.x = m1.m2.x * m2.m1.x + m1.m2.y * m2.m2.x + m1.m2.z * m2.m3.x;
	out.m2.y = m1.m2.x * m2.m1.y + m1.m2.y * m2.m2.y + m1.m2.z * m2.m3.y;
	out.m2.z = m1.m2.x * m2.m1.z + m1.m2.y * m2.m2.z + m1.m2.z * m2.m3.z;
	out.m3.x = m1.m3.x * m2.m1.x + m1.m3.y * m2.m2.x + m1.m3.z * m2.m3.x;
	out.m3.y = m1.m3.x * m2.m1.y + m1.m3.y * m2.m2.y + m1.m3.z * m2.m3.y;
	out.m3.z = m1.m3.x * m2.m1.z + m1.m3.y * m2.m2.z + m1.m3.z * m2.m3.z;
	return out;
}

matrix33 RotateX(matrix33 m, float angle)
{
	matrix33 out, rot;
	float s = sin(angle);
	float c = cos(angle);
	rot.m1 = (float3){1.0f, 0.0f, 0.0f};
	rot.m2 = (float3){0.0f, c, -s};
	rot.m3 = (float3){0.0f, s, c};
	out = Matrix33MulMatrix33(m, rot);
	return out;
}

matrix33 RotateY(matrix33 m, float angle)
{
	matrix33 out, rot;
	float s = sin(angle);
	float c = cos(angle);
	rot.m1 = (float3){c, 0.0f, s};
	rot.m2 = (float3){0.0f, 1.0f, 0.0f};
	rot.m3 = (float3){-s, 0.0f, c};
	out = Matrix33MulMatrix33(m, rot);
	return out;
}

matrix33 RotateZ(matrix33 m, float angle)
{
	matrix33 out, rot;
	float s = sin(angle);
	float c = cos(angle);
	rot.m1 = (float3){c, -s, 0.0f};
	rot.m2 = (float3){s, c, 0.0f};
	rot.m3 = (float3){0.0f, 0.0f, 1.0f};
	out = Matrix33MulMatrix33(m, rot);
	return out;
}

float3 RotateAroundVectorByAngle(float3 origin, float3 axis, float angle)
{
	float3 vector = origin * cos(angle);
	vector += cross(axis, origin) * sin(angle);
	vector += axis * dot(axis, origin) * (1.0f - cos(angle));
	return vector;
}

float4 RotateAroundVectorByAngle4(float4 origin4d, float3 axis, float angle)
{
	float3 origin = origin4d.xyz;
	float3 vector = origin * cos(angle);
	vector += cross(axis, origin) * sin(angle);
	vector += axis * dot(axis, origin) * (1.0f - cos(angle));
	return (float4){vector.x, vector.y, vector.z, origin4d.w};
}

float SmoothConditionAGreaterB(float a, float b, float sharpness)
{
	return native_recip(1.0f + native_exp(sharpness * (b - a)));
}

float SmoothConditionALessB(float a, float b, float sharpness)
{
	return native_recip(1.0f + native_exp(sharpness * (a - b)));
}

inline float3 wrap(float3 x, float3 a, float3 s)
{
	x -= s;
	float3 out;
	out.x = x.x - a.x * floor(x.x / a.x) + s.x;
	out.y = x.y - a.y * floor(x.y / a.y) + s.y;
	out.z = x.z - a.z * floor(x.z / a.z) + s.z;
	return out;
}

//********** Random ******************************
int RandomInt(int *randomSeed)
{
	int s = *randomSeed;
	int i = 0;
	int const a = 15484817;
	int const m = 6571759;
	s = ((long)(s * a)) % m;

	return *randomSeed = s;
}

int Random(int max, int *randomSeed)
{
	return RandomInt(randomSeed) % (max + 1);
}

#endif

#endif // MANDELBULBER2_OPENCL_ALGEBRA_HPP_
