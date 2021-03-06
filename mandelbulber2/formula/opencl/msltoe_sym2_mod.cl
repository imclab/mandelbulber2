/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * MsltoeSym2Mod based on the formula from Mandelbulb3D
 * @reference http://www.fractalforums.com/theory/choosing-the-squaring-formula-by-location/15/
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

REAL4 MsltoeSym2ModIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 c = aux->const_c;

	aux->r_dz = aux->r_dz * 2.0f * aux->r;
	REAL4 temp = z;

	if (fabs(z.y) < fabs(z.z)) // then swap
	{
		z.y = temp.z; // making z.y furthest away from axis
		z.z = temp.y;
	}
	if (z.y > z.z) // then change sign of z.x and z.z
	{
		z.x = -z.x;
	}

	REAL4 z2 = z * z;								// squares
	REAL v3 = (z2.x + z2.y + z2.z); // sum of squares
	// if (v3 < 1e-21f && v3 > -1e-21f)
	//	v3 = (v3 > 0) ? 1e-21f : -1e-21f;
	REAL zr = 1.0f - native_divide(z2.z, v3);
	temp.x = (z2.x - z2.y) * zr;
	temp.y = 2.0f * z.x * z.y * zr * fractal->transformCommon.scale; // scaling temp.y
	temp.z = 2.0f * z.z * native_sqrt(z2.x + z2.y);
	z = temp + fractal->transformCommon.additionConstant000;

	if (fractal->transformCommon.addCpixelEnabledFalse)
	{
		REAL4 tempFAB = c;
		if (fractal->transformCommon.functionEnabledx) tempFAB.x = fabs(tempFAB.x);
		if (fractal->transformCommon.functionEnabledy) tempFAB.y = fabs(tempFAB.y);
		if (fractal->transformCommon.functionEnabledz) tempFAB.z = fabs(tempFAB.z);

		tempFAB *= fractal->transformCommon.constantMultiplier000;

		z.x += sign(z.x) * tempFAB.x;
		z.y += sign(z.y) * tempFAB.y;
		z.z += sign(z.z) * tempFAB.z;
	}

	REAL lengthTempZ = length(-z);
	// if (lengthTempZ > -1e-21f)
	//	lengthTempZ = -1e-21f;   //  z is neg.)
	z *= 1.0f + native_divide(fractal->transformCommon.offset, lengthTempZ);
	z *= fractal->transformCommon.scale1;
	aux->r_dz *= fabs(fractal->transformCommon.scale1);
	return z;
}