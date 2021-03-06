/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * fabs.  Add fabs constantV2,  z = fabs( z + constant) - fabs( z - constant) - z:
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

REAL4 TransfFabsAddTgladFold4dIteration(
	REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	Q_UNUSED(aux);

	z = fabs(z + fractal->transformCommon.additionConstant0000)
			- fabs(z - fractal->transformCommon.additionConstant0000) - z;
	return z;
}