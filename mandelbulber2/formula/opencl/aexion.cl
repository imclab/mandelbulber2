/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Aexion's Quadray Sets from FractalForums
 * @reference http://www.fractalforums.com/the-3d-mandelbulb/quadray-sets/msg31458/#msg31458
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

REAL4 AexionIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (aux->i == 0)
	{
		REAL cx = fabs(aux->c.x + aux->c.y + aux->c.z) + fractal->aexion.cadd;
		REAL cy = fabs(-aux->c.x - aux->c.y + aux->c.z) + fractal->aexion.cadd;
		REAL cz = fabs(-aux->c.x + aux->c.y - aux->c.z) + fractal->aexion.cadd;
		REAL cw = fabs(aux->c.x - aux->c.y - aux->c.z) + fractal->aexion.cadd;
		aux->c.x = cx;
		aux->c.y = cy;
		aux->c.z = cz;
		aux->cw = cw;
		REAL tempX = fabs(z.x + z.y + z.z) + fractal->aexion.cadd;
		REAL tempY = fabs(-z.x - z.y + z.z) + fractal->aexion.cadd;
		REAL tempZ = fabs(-z.x + z.y - z.z) + fractal->aexion.cadd;
		REAL tempW = fabs(z.x - z.y - z.z) + fractal->aexion.cadd;
		z.x = tempX;
		z.y = tempY;
		z.z = tempZ;
		z.w = tempW;
	}
	REAL tempX = mad(z.x, z.x, -z.y * z.y) + mad(2.0f * z.w, z.z, aux->c.x);
	REAL tempY = mad(z.y, z.y, -z.x * z.x) + mad(2.0f * z.w, z.z, aux->c.y);
	REAL tempZ = mad(z.z, z.z, -z.w * z.w) + mad(2.0f * z.x, z.y, aux->c.z);
	REAL tempW = mad(z.w, z.w, -z.z * z.z) + mad(2.0f * z.x, z.y, aux->cw);
	z.x = tempX;
	z.y = tempY;
	z.z = tempZ;
	z.w = tempW;
	return z;
}