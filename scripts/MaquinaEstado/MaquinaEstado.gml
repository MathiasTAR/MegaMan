// Iniciar maquina de estado
function estado() constructor
{
	// Iniciar estado
	static inicia = function () {};
	// Rodando o estado
	static roda = function () {};
	// Finaliza o estado
	static finaliza = function () {};
}

//Funções para controlar a maquina

//Iniciar estado
function inicia_estado(_estado)
{
	// Salvando estado passado
	estado_atual = _estado;
	
	// Iniciando estado atual
	estado_atual.inicia();
}

// Rodando o estado
function roda_estado () 
{
	estado_atual.roda();
}

// trocando o estado
function troca_estado(_estado)
{
	// Finalizar estado atual
	estado_atual.finaliza();
	
	// Roda o proximo estado
	estado_atual = _estado;
	
	// Iniciando o proximo estado
	estado_atual.inicia();
	
}