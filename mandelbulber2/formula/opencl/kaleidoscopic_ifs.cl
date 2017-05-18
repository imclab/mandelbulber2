/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Kaleidoscopic Iterated Function Systems (IFS)
 * @reference
 * http://www.fractalforums.com/ifs-iterated-function-systems/kaleidoscopic-(escape-time-ifs)/
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
inline void KaleidoscopicIFSIteration(
	float4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (fractal->IFS.absX) z->x = fabs(z->x);
	if (fractal->IFS.absY) z->y = fabs(z->y);
	if (fractal->IFS.absZ) z->z = fabs(z->z);

	for (int i = 0; i < IFS_VECTOR_COUNT; i++)
	{
		if (fractal->IFS.enabled[i])
		{
			z->xyz = Matrix33MulFloat3(fractal->IFS.rot[i], *z);
			float length = dot(*z, fractal->IFS.direction[i]);

			if (length < fractal->IFS.distance[i])
			{
				*z -= fractal->IFS.direction[i]
							* (2.0f * (length - fractal->IFS.distance[i]) * fractal->IFS.intensity[i]);
			}
		}
	}

	if (fractal->IFS.rotationEnabled)
		z->xyz =
			Matrix33MulFloat3(fractal->IFS.mainRot, *z - fractal->IFS.offset) + fractal->IFS.offset;

	if (fractal->IFS.edge.x > 0.0f) z->x = fractal->IFS.edge.x - fabs(fractal->IFS.edge.x - z->x);
	if (fractal->IFS.edge.y > 0.0f) z->y = fractal->IFS.edge.y - fabs(fractal->IFS.edge.y - z->y);
	if (fractal->IFS.edge.z > 0.0f) z->z = fractal->IFS.edge.z - fabs(fractal->IFS.edge.z - z->z);

	*z *= fractal->IFS.scale;
	if (fractal->IFS.mengerSpongeMode)
	{
		z->x -= fractal->IFS.offset.x * (fractal->IFS.scale - 1.0f);
		z->y -= fractal->IFS.offset.y * (fractal->IFS.scale - 1.0f);
		if (z->z > 0.5f * fractal->IFS.offset.z * (fractal->IFS.scale - 1.0f))
			z->z -= fractal->IFS.offset.z * (fractal->IFS.scale - 1.0f);
	}
	else
	{
		*z -= fractal->IFS.offset * (fractal->IFS.scale - 1.0f);
	}
	aux->DE *= fractal->IFS.scale;
}
#else
inline void KaleidoscopicIFSIteration(
	double4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (fractal->IFS.absX) z->x = fabs(z->x);
	if (fractal->IFS.absY) z->y = fabs(z->y);
	if (fractal->IFS.absZ) z->z = fabs(z->z);

	for (int i = 0; i < IFS_VECTOR_COUNT; i++)
	{
		if (fractal->IFS.enabled[i])
		{
			z->xyz = Matrix33MulFloat3(fractal->IFS.rot[i], *z);
			double length = dot(*z, fractal->IFS.direction[i]);

			if (length < fractal->IFS.distance[i])
			{
				*z -= fractal->IFS.direction[i]
							* (2.0 * (length - fractal->IFS.distance[i]) * fractal->IFS.intensity[i]);
			}
		}
	}

	if (fractal->IFS.rotationEnabled)
		z->xyz =
			Matrix33MulFloat3(fractal->IFS.mainRot, *z - fractal->IFS.offset) + fractal->IFS.offset;

	if (fractal->IFS.edge.x > 0.0) z->x = fractal->IFS.edge.x - fabs(fractal->IFS.edge.x - z->x);
	if (fractal->IFS.edge.y > 0.0) z->y = fractal->IFS.edge.y - fabs(fractal->IFS.edge.y - z->y);
	if (fractal->IFS.edge.z > 0.0) z->z = fractal->IFS.edge.z - fabs(fractal->IFS.edge.z - z->z);

	*z *= fractal->IFS.scale;
	if (fractal->IFS.mengerSpongeMode)
	{
		z->x -= fractal->IFS.offset.x * (fractal->IFS.scale - 1.0);
		z->y -= fractal->IFS.offset.y * (fractal->IFS.scale - 1.0);
		if (z->z > 0.5 * fractal->IFS.offset.z * (fractal->IFS.scale - 1.0))
			z->z -= fractal->IFS.offset.z * (fractal->IFS.scale - 1.0);
	}
	else
	{
		*z -= fractal->IFS.offset * (fractal->IFS.scale - 1.0);
	}
	aux->DE *= fractal->IFS.scale;
}
#endif
