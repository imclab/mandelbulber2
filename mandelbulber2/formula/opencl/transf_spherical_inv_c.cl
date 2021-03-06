/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * inverted sphere z & c- A transform from M3D
 * @reference
 * http://www.fractalforums.com/mandelbulb-3d/custom-formulas-and-transforms-release-t17106/
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

REAL4 TransfSphericalInvCIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 c = aux->const_c;

	c *= fractal->transformCommon.constantMultiplier111;
	REAL rSqrL = mad(c.z, c.z, mad(c.x, c.x, c.y * c.y));
	// if (rSqrL < 1e-21f) rSqrL = 1e-21f;
	rSqrL = native_recip(rSqrL);
	c *= rSqrL;

	rSqrL = mad(z.z, z.z, mad(z.x, z.x, z.y * z.y));
	// if (rSqrL < 1e-21f) rSqrL = 1e-21f;
	rSqrL = native_recip(rSqrL);
	z *= rSqrL;
	return z;
}