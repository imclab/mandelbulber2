/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Box Fold
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

REAL4 TransfBoxFoldIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (fabs(z.x) > fractal->mandelbox.foldingLimit)
	{
		z.x = mad(sign(z.x), fractal->mandelbox.foldingValue, -z.x);
		aux->color += fractal->mandelbox.color.factor.x;
	}
	if (fabs(z.y) > fractal->mandelbox.foldingLimit)
	{
		z.y = mad(sign(z.y), fractal->mandelbox.foldingValue, -z.y);
		aux->color += fractal->mandelbox.color.factor.y;
	}
	REAL zLimit = fractal->mandelbox.foldingLimit * fractal->transformCommon.scale1;
	REAL zValue = fractal->mandelbox.foldingValue * fractal->transformCommon.scale1;
	if (fabs(z.z) > zLimit)
	{
		z.z = mad(sign(z.z), zValue, -z.z);
		aux->color += fractal->mandelbox.color.factor.z;
	}
	return z;
}