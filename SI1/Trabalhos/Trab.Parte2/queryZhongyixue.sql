/*
*	Sistemas de Informa��o I
*	2009/2010 Semestre Inverno
*	Trabalho Pr�tico (Parte II)
*	
*	Elaborado por:
*	Grupo 1
*	30896 � Ricardo Canto
*	31401 � Nuno Cancelo
*	33595 � Nuno Sousa
*/

use Zhongyixue
/**
*	i)Quais os pacientes que ainda n�o efectuaram nenhuma consulta. 
*	nota: apresentar informa��o sobre BI, nome e data de registo no centro.
*/
SELECT PESSOA.BI,PESSOA.nomePessoa,PACIENTE.dataRegisto
FROM
	PESSOA INNER JOIN PACIENTE ON (PESSOA.BI = PACIENTE.BI)
WHERE PACIENTE.BI NOT IN (
	SELECT DISTINCT CONSULTA.BIPaciente 
	FROM CONSULTA
);

/**
*	ii) Quais os tratamentos e respectivos terapeutas habilitados (BI e nome), 
*	para cada um dos padr�es cl�nicos j� diagnosticados a algum paciente, desde 
*	1 de Dezembro de 2009. nota: apresentar tamb�m a informa��o sobre o respectivo padr�o cl�nico.
*/

SELECT DISTINCT TERAPEUTA.BI, PESSOA.nomePessoa as Terapeuta,TRATAMENTO.descTratamento as Tratamento,
	PADRAO.nomePadrao as Padr�o,PADRAO.descPadrao
FROM
	PESSOA INNER JOIN TERAPEUTA ON (PESSOA.BI = TERAPEUTA.BI)
	INNER JOIN TERAPEUTA_ESPECIALIZACAO ON (TERAPEUTA.BI = TERAPEUTA_ESPECIALIZACAO.BITerapeuta)
	INNER JOIN TRATAMENTO ON (TERAPEUTA_ESPECIALIZACAO.nomeEspecializacao=TRATAMENTO.nomeEspecializacao)
	INNER JOIN TRATAMENTO_PADRAO ON (TRATAMENTO.numTratamento = TRATAMENTO_PADRAO.numTratamento)
	INNER JOIN SINTOMA_PADRAO ON (SINTOMA_PADRAO.numPadrao = TRATAMENTO_PADRAO.numPadrao)
	INNER JOIN SINTOMA_PACIENTE ON (SINTOMA_PADRAO.numPadrao = SINTOMA_PACIENTE.numSintoma)
	INNER JOIN PADRAO ON (SINTOMA_PADRAO.numPadrao = PADRAO.numPadrao)
;
/**
*	iii) Quais os terapeutas, em fun��es, que ainda n�o realizaram nenhuma consulta 
*	mas est�o habilitados a realizar algum dos tratamentos recomendados para o padr�o 
*	cl�nico �Vazio de Sangue�. nota: mostrar a informa��o sobre o BI, nome e telefone dos terapeutas.
*/
SELECT TERAPEUTA.BI, PESSOA.nomePessoa as Terapeuta, PESSOA.telefone as Telefone
FROM
	PESSOA INNER JOIN TERAPEUTA ON (PESSOA.BI = TERAPEUTA.BI)
	INNER JOIN TERAPEUTA_ESPECIALIZACAO ON (TERAPEUTA.BI = TERAPEUTA_ESPECIALIZACAO.BITerapeuta)
	INNER JOIN TRATAMENTO ON (TERAPEUTA_ESPECIALIZACAO.nomeEspecializacao=TRATAMENTO.nomeEspecializacao)
	INNER JOIN TRATAMENTO_PADRAO ON (TRATAMENTO.numTratamento = TRATAMENTO_PADRAO.numTratamento)
	INNER JOIN PADRAO ON (TRATAMENTO_PADRAO.numPadrao = PADRAO.numPadrao)
WHERE PADRAO.nomePadrao = 'Vazio de Sangue' AND TERAPEUTA.BI NOT IN (
	SELECT DISTINCT CONSULTA.BITerapeuta
	FROM CONSULTA
);

/**
*	iv) Qual o padr�o cl�nico mais frequentemente diagnosticado aos pacientes cujo 
*	estado civil � �casado�. nota: mostrar a informa��o sobre a refer�ncia, a descri��o e a designa��o.
*/
SELECT TOP 1 COUNT(PADRAO.numPadrao)as Frequ�ncia, PADRAO.numPadrao as Refer�ncia, PADRAO.nomePadrao as Designa��o, PADRAO.descPadrao
FROM 
	PADRAO INNER JOIN SINTOMA_PADRAO ON (PADRAO.numPadrao = SINTOMA_PADRAO.numPadrao)
	INNER JOIN SINTOMA_PACIENTE ON (SINTOMA_PADRAO.numSintoma = SINTOMA_PACIENTE.numSintoma)
	INNER JOIN PACIENTE ON (SINTOMA_PACIENTE.BIPaciente = PACIENTE.BI)
WHERE PACIENTE.estadoCivil = 'Casado'
GROUP BY PADRAO.numPadrao, PADRAO.nomePadrao, PADRAO.descPadrao
ORDER BY 1 DESC;

/**
*	v) Quais os terapeutas, que tamb�m s�o pacientes, e que j� realizaram algum tratamento 
*	para o qual est�o tamb�m habilitados. nota: mostrar a informa��o sobre o BI, nome, data de nascimento, email.
*/
SELECT TERAPEUTA.BI as Identifica��o, PESSOA.nomePessoa as Nome, PESSOA.dataNasc as 'Data de Nascimento', PACIENTE.email as 'Email'
FROM 
	TERAPEUTA INNER JOIN PESSOA ON (TERAPEUTA.BI = PESSOA.BI)
	INNER JOIN PACIENTE ON (TERAPEUTA.BI = PACIENTE.BI)
	INNER JOIN SESSAO ON (PACIENTE.BI = SESSAO.BIPaciente)
	INNER JOIN TRATAMENTO ON (SESSAO.numTratamento = TRATAMENTO.numTratamento)
	INNER JOIN ESPECIALIZACAO ON (ESPECIALIZACAO.nomeEspecializacao = TRATAMENTO.nomeEspecializacao)
WHERE (ESPECIALIZACAO.nomeEspecializacao = TRATAMENTO.nomeEspecializacao)
UNION
SELECT TERAPEUTA.BI as Identifica��o, PESSOA.nomePessoa as Nome, PESSOA.dataNasc as 'Data de Nascimento', PACIENTE.email as 'Email'
FROM 
	TERAPEUTA INNER JOIN PESSOA ON (TERAPEUTA.BI = PESSOA.BI)
	INNER JOIN PACIENTE ON (TERAPEUTA.BI = PACIENTE.BI)
	INNER JOIN CONSULTA_NAOPRESENCIAL ON (PACIENTE.BI = CONSULTA_NAOPRESENCIAL .BIPaciente)
	INNER JOIN TRATAMENTO ON (CONSULTA_NAOPRESENCIAL.numTratamento = TRATAMENTO.numTratamento)
	INNER JOIN ESPECIALIZACAO ON (ESPECIALIZACAO.nomeEspecializacao = TRATAMENTO.nomeEspecializacao)
WHERE (ESPECIALIZACAO.nomeEspecializacao = TRATAMENTO.nomeEspecializacao)

/**
*	vi) Qual(is) o(s) paciente(s) que n�o frequenta(m) a cl�nica h� mais tempo. 
*	nota: contemplar toda a informa��o dispon�vel sobre o paciente.
*/
SELECT CONSULTA.dataConsulta  as '�ltima Consulta', PESSOA.nomePessoa as Nome,PESSOA.BI, PESSOA.NIF, PESSOA.idade, 
	PESSOA.dataNasc as 'Data Nascimento',PESSOA.morada, PESSOA.telefone, PACIENTE.dataRegisto as 'Data Registo', 
	PACIENTE.declRespon as Declara��o, PACIENTE.email, PACIENTE.estadoCivil as 'Estado Civil', PACIENTE.profissao as Profiss�o
FROM PESSOA INNER JOIN PACIENTE ON (PESSOA.BI = PACIENTE.BI)
	INNER JOIN CONSULTA ON (PACIENTE.BI = CONSULTA.BIPaciente)
WHERE CONSULTA.dataConsulta IN
	(SELECT TOP 1 MAX(CONSULTA.dataConsulta)
	FROM 
		CONSULTA INNER JOIN PACIENTE ON (CONSULTA.BIPaciente = PACIENTE.BI)
	GROUP BY PACIENTE.BI
	)

/**
*	vii) Para cada um dos tratamentos presenciais, qual o somat�rio total de horas de 
*	terapia j� realizadas no centro. nota: ordenar por ordem decrescente do total de horas.
*/
SELECT SUM(DATEDIFF(MINUTE, '0:00:00', SESSAO.duracao))/60.0 as 'Total Horas', SESSAO.numTratamento as Tratamento
FROM
	SESSAO
GROUP BY SESSAO.numTratamento
ORDER BY 1 DESC
;
/**
*	viii) Quais os terapeutas que est�o habilitados a realizar todos os tratamentos 
*	dispon�veis no centro. nota: ordenar os terapeutas por ordem decrescente de idade.
*/
SELECT PESSOA.nomePessoa as Terapeuta, PESSOA.idade as Idade
FROM PESSOA INNER JOIN TERAPEUTA ON (PESSOA.BI = TERAPEUTA.BI)
WHERE TERAPEUTA.emFuncoes = 1 AND NOT EXISTS (
	SELECT ESPECIALIZACAO.nomeEspecializacao
	FROM ESPECIALIZACAO 
	WHERE nomeEspecializacao NOT IN (
		SELECT TERAPEUTA_ESPECIALIZACAO.nomeEspecializacao FROM TERAPEUTA_ESPECIALIZACAO
		WHERE (TERAPEUTA.BI  = TERAPEUTA_ESPECIALIZACAO.BITerapeuta)
))
ORDER BY PESSOA.idade DESC
;

/**
*	ix) Quais os pacientes a quem j� foi receitada mais do que 3 vezes a f�rmula de 
*	fitoterapia n� 33. nota: mostrar toda a informa��o relativa ao paciente.
*/
SELECT PACIENTE.*, PESSOA.*
FROM PESSOA INNER JOIN PACIENTE ON (PESSOA.BI = PACIENTE.BI)
	INNER JOIN CONSULTA_NAOPRESENCIAL ON (PACIENTE.BI = CONSULTA_NAOPRESENCIAL.BIPaciente)
	INNER JOIN NAOPRESENCIAL ON (CONSULTA_NAOPRESENCIAL.numTratamento = NAOPRESENCIAL.numTratamento)
WHERE (NAOPRESENCIAL.numFormula = 33)
GROUP BY PACIENTE.BI,PESSOA.nomePessoa, PESSOA.NIF,PACIENTE.profissao,PACIENTE.estadoCivil,PESSOA.dataNasc,
	PACIENTE.declRespon,PACIENTE.email,PACIENTE.dataRegisto,PESSOA.idade,PESSOA.telefone,PESSOA.BI,PESSOA.morada
HAVING (COUNT(PACIENTE.BI) > 3);	

/**
*	x) Quais os pacientes que estejam inscritos na clinica e que tenham desempenhado
*	fun��es como terapeutas.
*/
SELECT PESSOA.nomePessoa,TERAPEUTA.emFuncoes 
FROM 
	TERAPEUTA INNER JOIN PESSOA ON (TERAPEUTA.BI = PESSOA.BI)	
WHERE TERAPEUTA.emFuncoes = 0 AND EXISTS (
	SELECT PACIENTE.BI FROM PACIENTE
	WHERE PACIENTE.BI = TERAPEUTA.BI
);