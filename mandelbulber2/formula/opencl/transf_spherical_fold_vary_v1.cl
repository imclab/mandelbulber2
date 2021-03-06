/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * spherical fold varyV1 MBox type
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

REAL4 TransfSphericalFoldVaryV1Iteration(
	REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL r2 = dot(z, z);
	REAL tempVCf = fractal->mandelbox.foldingSphericalFixed; // constant to be varied
	REAL tempVCm = fractal->mandelbox.foldingSphericalMin;

	if (aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA)
	{
		int iterationRange =
			fractal->transformCommon.stopIterationsA - fractal->transformCommon.startIterationsA;
		int currentIteration = (aux->i - fractal->transformCommon.startIterationsA);
		tempVCf +=
			fractal->transformCommon.offset * native_divide((1.0f * currentIteration), iterationRange);
	}
	if (aux->i >= fractal->transformCommon.stopIterationsA)
	{
		tempVCf = (tempVCf + fractal->transformCommon.offset);
	}
	if (aux->i >= fractal->transformCommon.startIterationsB
			&& aux->i < fractal->transformCommon.stopIterationsB)
	{

		int iterationRange =
			fractal->transformCommon.stopIterationsB - fractal->transformCommon.startIterationsB;
		int currentIteration = (aux->i - fractal->transformCommon.startIterationsB);
		tempVCm +=
			fractal->transformCommon.offset0 * native_divide((1.0f * currentIteration), iterationRange);
	}
	if (aux->i >= fractal->transformCommon.stopIterationsB)
	{
		tempVCm = tempVCm + fractal->transformCommon.offset0;
	}

	z += fractal->mandelbox.offset;

	tempVCm *= tempVCm;
	tempVCf *= tempVCf;

	if (r2 < tempVCm)
	{
		z *= native_divide(tempVCf, tempVCm);
		aux->DE *= native_divide(tempVCf, tempVCm);
		;
		aux->color += fractal->mandelbox.color.factorSp1;
	}
	else if (r2 < tempVCf)
	{
		REAL tglad_factor2 = native_divide(tempVCf, r2);
		z *= tglad_factor2;
		aux->DE *= tglad_factor2;
		aux->color += fractal->mandelbox.color.factorSp2;
	}
	z -= fractal->mandelbox.offset;
	return z;
}