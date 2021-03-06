/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Makin3D-2 found through the another shot at the holy grail topic at ff
 * @reference http://www.fractalforums.com/3d-fractal-generation/another-shot-at-the-holy-grail/
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

REAL4 Makin3d2Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	Q_UNUSED(fractal);
	Q_UNUSED(aux);

	REAL x2 = z.x * z.x;
	REAL y2 = z.y * z.y;
	REAL z2 = z.z * z.z;
	REAL newx = mad(z.z, 2.0f * z.y, x2);
	REAL newy = mad(-z.z, 2.0f * z.x, -y2);
	REAL newz = mad(z.y, 2.0f * z.x, -z2);
	z.x = newx;
	z.y = newy;
	z.z = newz;
	return z;
}