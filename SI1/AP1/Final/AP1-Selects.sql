/*------------------------------------------------------------------------------
ISEL - INSTITUTO SUPERIOR DE ENGENHARIA DE LISBOA
LEIC - LICENCIATURA DE ENGENHARIA DE INFORM�TICA E DE COMPUTADORES
ANO LECTIVO 2009-2010
SEMESTRE DE INVERNO
GRUPO 1:
30896 - RICARDO CANTO
31401 - NUNO CANCELO
33595 - NUNO SOUSA

RESOLU��O DA FICHA DE "AULA PR�TICA SOBRE SQL"
------------------------------------------------------------------------------*/
USE AP1;
SET
	DATEFORMAT DMY;
/*------------------------------------------------------------------------------
    EXERCICIO 1
------------------------------------------------------------------------------*/
/*1.1 QUAIS AS CATEGORIAS COM SAL�RIO BASE SUPERIOR A 1000 EUROS?*/
    SELECT
        DESIGNACAO 
    FROM
        DBO.CATEGORIA 
    WHERE
        SALARIOBASE>1000;
/*1.2 QUAIS OS NOMES DOS EMPREGADOS ADMITIDOS A 10 DE MAIO DE 2006?*/
    SELECT
        DISTINCT NOMEEMP 
    FROM
        DBO.EMPREGADO 
    WHERE
        DATAADMISSAO = '10-05-2006';
/*1.3 QUAIS OS EMPREGADOS QUE GANHAM MENOS DE 1000 EUROS?*/
    SELECT
        E.CODEMP,
        E.NOMEEMP 
    FROM
        DBO.EMPREGADO AS E 
            INNER JOIN DBO.CATEGORIA AS C 
            ON(E.CODCAT=C.CODCAT) 
    WHERE
        C.SALARIOBASE<1000;
/*
    1.4 QUAIS OS PROJECTOS (C�DIGO E DESCRI��O) ONDE PARTICIPAM EMPREGADOS DAS CATEGORIAS 1 E 2?
    2 IMPLEMENTA��ES
 */
/*IMPLEMENTA��O I*/
SELECT
	CODPROJ,
	DESCPROJ 
FROM
	PROJECTO PR 
		INNER JOIN (SELECT
						DISTINCT P.CODPROJ AS PCOD 
					FROM
						PARTICIPA AS P 
						INNER JOIN EMPREGADO AS E 
						ON (P.CODEMP=E.CODEMP) 
					WHERE
						E.CODCAT = 1 OR
						E.CODCAT = 2 
		)
		AS X 
		ON PR.CODPROJ=X.PCOD;
/*IMPLEMENTA��O II*/
SELECT
	P.CODPROJ,
	P.DESCPROJ 
FROM
	DBO.PROJECTO AS P 
		INNER JOIN (SELECT
						DISTINCT PAR.CODPROJ 
					FROM
						(	SELECT
								E.CODEMP 
							FROM
								DBO.EMPREGADO AS E 
							WHERE
								(E.CODCAT=1 OR
								E.CODCAT=2)
						)
						AS CAT1_2 
						INNER JOIN PARTICIPA AS PAR 
						ON(CAT1_2.CODEMP=PAR.CODEMP)
		)
		AS AUX 
		ON(P.CODPROJ=AUX.CODPROJ);

/*1.5 QUANTOS EMPREGADOS EXISTEM EM CADA CATEGORIA?*/
SELECT
	C.DESIGNACAO AS CATEGORIA,
	COUNT(E.CODEMP) 
FROM
	DBO.EMPREGADO AS E 
		INNER JOIN DBO.CATEGORIA AS C 
		ON(E.CODCAT = C.CODCAT) 
	GROUP BY
		C.DESIGNACAO;

/*------------------------------------------------------------------------------
    EXERCICIO 2
------------------------------------------------------------------------------*/
-- 2.1 LISTAR TODOS OS EMPREGADOS (C�DIGO E NOME) E RESPECTIVO CHEFE (C�DIGO E NOME) CASO TENHA CHEFE. 

/* ENTENDO QUE SEJA PARA LISTAR TODOS OS TUPLOS, SE TIVEREM CHEFE IDENTIFICA-LOS, CASO CONTR�RIO MOSTRAR NULL NESSE CAMPO */
SELECT
	E.CODEMP,
	E.NOMEEMP,
	E.CODEMPCHEFE,
	E2.NOMEEMP 
FROM
	EMPREGADO E 
		LEFT JOIN EMPREGADO E2 
		ON (E.CODEMPCHEFE = E2.CODEMP);
-- 2.2 QUAIS AS CATEGORIAS QUE N�O T�M EMPREGADOS ASSOCIADOS? 
SELECT
	C.CODCAT 
FROM
	CATEGORIA C 
WHERE
	C.CODCAT NOT IN (	SELECT
							DISTINCT E.CODCAT 
						FROM
							EMPREGADO E
	);
SELECT
	C.CODCAT 
FROM
	CATEGORIA C 
WHERE
	NOT EXISTS (SELECT
					DISTINCT E.CODCAT 
				FROM
					EMPREGADO E 
				WHERE
					C.CODCAT=E.CODCAT
	);
-- 2.3 QUAIS OS EMPREGADOS CHEFIADOS PELA Br�gida da Silva, ORDENADOS POR ORDEM CRESCENTE DE SAL�RIO? 
SELECT
	EMP.NOMEEMP,
	C.SALARIOBASE 
FROM
	(	SELECT
			E.NOMEEMP,
			E.CODCAT 
		FROM
			EMPREGADO E 
			LEFT JOIN EMPREGADO CHEFE 
			ON (E.CODEMPCHEFE = CHEFE.CODEMP) 
		WHERE
			CHEFE.NOMEEMP = 'Br�gida da Silva' 
	)
	AS EMP 
		INNER JOIN CATEGORIA C 
		ON (EMP.CODCAT=C.CODCAT) 
	ORDER BY
		2 ASC;
-- 2.4 QUAIS OS PROJECTOS EM QUE PARTICIPAM EMPREGADOS DO SEXO FEMININO COM SAL�RIO SUPERIOR A 500? 
SELECT
	EMP.CODEMP,
	EMP.NOMEEMP,
	EMP.SALARIOBASE,
	P.CODPROJ 
FROM
	(	SELECT
			EF.CODEMP,
			EF.NOMEEMP,
			C.SALARIOBASE 
		FROM
			(	SELECT
					* 
				FROM
					EMPREGADO 
				WHERE
					GENERO='F'
			)
			AS EF 
			INNER JOIN CATEGORIA AS C 
			ON (EF.CODCAT=C.CODCAT AND
			C.SALARIOBASE>500) 
	)
	AS EMP 
		INNER JOIN PARTICIPA AS P 
		ON (EMP.CODEMP = P.CODEMP)
		-- 2.5 QUANTOS EMPREGADOS S�O CHEFES? 
SELECT
	COUNT(DISTINCT CODEMPCHEFE) 
FROM
	EMPREGADO;
-- 2.6 QUAL O DIA ONDE FORAM ADMITIDOS MAIS EMPREGADOS E QUAL A QUANTIDADE? 
SELECT
	DATAADMISSAO,
	COUNT(CODEMP) AS ADMITIDOS 
FROM
	EMPREGADO 
GROUP BY
	DATAADMISSAO 
HAVING
	COUNT(CODEMP) = (	SELECT
							MAX(X.ADM) 
						FROM
							(	SELECT
									DATAADMISSAO,
									COUNT(CODEMP) AS ADM 
								FROM
									EMPREGADO 
								GROUP BY
									DATAADMISSAO 
							)
							AS X 
	);
/*------------------------------------------------------------------------------
    EXERCICIO 3
------------------------------------------------------------------------------*/
-- 3.1 QUAL A M�DIA DOS SAL�RIOS DOS EMPREGADOS DE CADA PROJECTO?
SELECT
	PR.CODPROJ,
	AVG(EMPLOYEE.SALARIOBASE) 
FROM
	PARTICIPA PR 
		INNER JOIN (SELECT
						E.CODEMP,
						E.NOMEEMP,
						C.SALARIOBASE 
					FROM
						CATEGORIA C 
						INNER JOIN EMPREGADO E 
						ON (C.CODCAT=E.CODCAT)
		)
		AS EMPLOYEE 
		ON(EMPLOYEE.CODEMP = PR.CODEMP) 
	GROUP BY
		PR.CODPROJ;
-- 3.2 QUAIS OS EMPREGADOS (C�DIGO E NOME) QUE RECEBEM UM SAL�RIO ACIMA DA M�DIA E QUE J� PARTICIPARAM  EM ALGUM PROJECTO? 
SELECT
	E1.CODEMP,
	E1.NOMEEMP 
FROM
	EMPREGADO E1 
		INNER JOIN CATEGORIA C1 
		ON (E1.CODCAT=C1.CODCAT) 
WHERE
	C1.SALARIOBASE > (	SELECT
							AVG(C1.SALARIOBASE) 
						FROM
							EMPREGADO E2 
							INNER JOIN CATEGORIA C1 
							ON (E2.CODCAT=C1.CODCAT) 
	)
	AND
	E1.CODEMP IN (	SELECT
						CODEMP 
					FROM
						PARTICIPA
	);
-- 3.3 QUAIS OS EMPREGADOS QUE NUNCA PARTICIPARAM EM PROJECTOS COM MAIS DO QUE 75 HORAS? 
SELECT
	E.CODEMP,
	E.NOMEEMP 
FROM
	EMPREGADO E 
WHERE
	NOT EXISTS (SELECT
					* 
				FROM
					PROJECTO AS PR 
					INNER JOIN PARTICIPA AS PA 
					ON(PR.CODPROJ=PA.CODPROJ) 
				WHERE
					NUMHORAS>75 AND
					E.CODEMP = PA.CODEMP
	);
-- 3.4 QUAIS OS EMPREGADOS QUE NUNCA PARTICIPARAM EM PROJECTOS EM QUE PARTICIPARAM EMPREGADOS DO SEXO MASCULINO? 
SELECT
	E.CODEMP,
	E.NOMEEMP 
FROM
	EMPREGADO E 
WHERE
	NOT EXISTS (SELECT
					* 
				FROM
					PROJECTO AS PR 
					INNER JOIN PARTICIPA AS PA 
					ON(PR.CODPROJ=PA.CODPROJ) 
				WHERE
					E.CODEMP = PA.CODEMP AND
					E.GENERO='M'
	);
-- 3.5 QUAIS OS PROJECTOS EM QUE APENAS PARTICIPARAM EMPREGADOS CUJO SAL�RIO � SUPERIOR � MEDIA DAS M�DIAS DOS SAL�RIOS DOS EMPREGADOS POR PROJECTO 
--( UTILIZE O RESULTADO OBTIDO NA AL�NEA 3.1)? 
SELECT
	DISTINCT PRJ.DESCPROJ 
FROM
	PARTICIPA P1 
		INNER JOIN PROJECTO PRJ 
		ON (PRJ.CODPROJ = P1.CODPROJ) 
WHERE
	EXISTS (
	/*
                QUAIS OS EMPREGADOS
                */
SELECT
	E1.CODEMP 
FROM
	EMPREGADO E1 
	INNER JOIN CATEGORIA C1 
	ON(C1.CODCAT=E1.CODCAT) 
WHERE
	C1.SALARIOBASE > (
	/*
                            MEDIA DAS MEDIAS
                            */
SELECT
	AVG(MED.PRJ_MEDIA) 
FROM
	(	SELECT
			PR.CODPROJ,
			AVG(EMPLOYEE.SALARIOBASE) AS PRJ_MEDIA 
		FROM
			PARTICIPA PR 
			INNER JOIN (SELECT
							E.CODEMP,
							E.NOMEEMP,
							C.SALARIOBASE 
						FROM
							CATEGORIA C 
							INNER JOIN EMPREGADO E 
							ON (C.CODCAT=E.CODCAT)
			)
			AS EMPLOYEE 
			ON(EMPLOYEE.CODEMP = PR.CODEMP) 
			GROUP BY
				PR.CODPROJ 
	)
	AS MED ) AND
P1.CODEMP = E1.CODEMP );
-- 3.6 QUAL O EMPREGADO QUE TEM MAIOR N�MERO DE PARTICIPA��ES EM PROJECTOS? 
SELECT
	E.CODEMP,
	E.NOMEEMP,
	COUNT(P.CODPROJ) AS N_PROJECTOS 
FROM
	EMPREGADO AS E 
		INNER JOIN PARTICIPA AS P 
		ON (E.CODEMP=P.CODEMP) 
	GROUP BY
		E.CODEMP,
		E.NOMEEMP 
	HAVING
		COUNT(P.CODPROJ) = (SELECT
								MAX(X.PARTICIPACOES) 
							FROM
								(	SELECT
										COUNT(PP.CODPROJ) AS PARTICIPACOES 
									FROM
										PARTICIPA PP 
									GROUP BY
										PP.CODEMP
								)
								AS X
		)
GO
