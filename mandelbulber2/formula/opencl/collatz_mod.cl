/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * CollatzModIteration formula
 * @reference https://mathr.co.uk/blog/2016-04-10_collatz_fractal.html
 *            https://en.wikipedia.org/wiki/Collatz_conjecture#Iterating_on_real_or_complex_numbers
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

REAL4 CollatzModIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 c = aux->const_c;

	z = fractal->transformCommon.constantMultiplierB111
			+ mad(fractal->transformCommon.scale4, z,
					-(mad(fractal->transformCommon.scale2, z, fractal->transformCommon.constantMultiplier111))
						* RotateAroundVectorByAngle4(z, fractal->transformCommon.constantMultiplier111.xyz,
								M_PI_F * fractal->transformCommon.scale1)); // * cPI ;

	z *= fractal->transformCommon.scale025;

	aux->DE = mad(aux->DE * 4.0f, fractal->analyticDE.scaleLin, 1.0f);

	if (fractal->transformCommon.addCpixelEnabledFalse)
	{
		c = (REAL4){c.z, c.y, c.x, c.w};
		z += c * fractal->transformCommon.constantMultiplierA111;
	}
	return z;
}