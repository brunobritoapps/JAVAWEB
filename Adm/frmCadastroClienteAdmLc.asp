<!--#include file="../_config/_config.asp" -->
<%Call open()%>
<%Call GetSessionAdm()%>
<%
	Dim RazaoSocial	
	Dim NomeFantasia
	Dim CNPJ
	Dim InscEstadual
	Dim DDD
	Dim Telefone
	Dim Categoria
	Dim Grupo
	Dim IDCep
	Dim CEP
	Dim LogCliente
	Dim CompLog
	Dim Numero
	Dim Bairro
	Dim Municipio
	Dim Estado
	Dim IDCepColeta
	Dim CEPColeta
	Dim LogColeta
	Dim CompLogColeta
	Dim NumeroColeta
	Dim BairroColeta
	Dim MunicipioColeta
	Dim EstadoColeta
	Dim isColetaDomiciliar
	Dim StatusCliente
	Dim IDPontoColeta
	Dim NomePontoColeta
	Dim CNPJPontoColeta
	Dim MotivoStatus
	Dim ContatoRespColeta
	Dim DDDContatoRespColeta
	Dim	TelefoneContatoRespColeta
	Dim TipoColeta

	Sub GetClientes()
		Dim sSql, arrClientes, intClientes, i
		sSql = "SELECT " & _ 
						"A.[idClientes], " & _ 
						"A.[razao_social], " & _ 
						"A.[nome_fantasia], " & _ 
						"A.[cnpj], " & _ 
						"A.[inscricao_estadual], " & _ 
						"A.[ddd], " & _ 
						"A.[telefone], " & _ 
						"A.[compl_endereco], " & _ 
						"A.[compl_endereco_coleta], " & _ 
						"A.[numero_endereco], " & _
						"A.[numero_endereco_coleta], " & _ 
						"A.[contato_respcoleta], " & _ 
						"A.[ddd_respcoleta], " & _ 
						"A.[telefone_respcoleta], " & _ 
						"A.[numero_sequencial], " & _ 
						"A.[data_atualizacao_sequencial], " & _ 
						"A.[typeColect], " & _ 
						"A.[status_cliente], " & _ 
						"A.[bonus_type], " & _
						"B.[idCategorias], " & _
						"B.[descricao], " & _
						"C.[idGrupos], " & _
						"C.[descricao] " & _
						"FROM [marketingoki2].[dbo].[Clientes] AS A " & _
						"LEFT JOIN [marketingoki2].[dbo].[Categorias] AS B " & _
						"ON A.[Categorias_idCategorias] = B.[idCategorias] " & _
						"LEFT JOIN [marketingoki2].[dbo].[Grupos] AS C " & _
						"ON A.[Grupos_idGrupos] = C.[idGrupos]"
		
		If Request.ServerVariables("HTTP_METHOD") = "GET" And Request.QueryString("find") Then
			sSql = sSql & GetWhereClientes()
'			response.write sSql
'			response.end()
		End If						
						
		Call search(sSql, arrClientes, intClientes)

		If intClientes > -1 Then 
			'PAGINACAO NOVA - JADILSON
			Dim intUltima, _
			    intNumProds, _
					intProdsPorPag, _
					intNumPags, _
					intPag, _
					intPorLinha

			intProdsPorPag = 30 'numero de registros mostrados na pagina
			intNumProds = UBound(arrClientes, 2) + 1 'numero total de registros
			
			intPag = CInt(Request("pg")) 'pagina atual da paginacao
			If intPag <= 0 Then intPag = 1
			if request.servervariables("HTTP_METHOD") = "POST" then	intPag=1
			
			intUltima   = intProdsPorPag * intPag - 1
			If intUltima > (intNumProds - 1) Then intUltima = (intNumProds - 1)
				
			intNumPags = (intNumProds - (intNumProds mod intProdsPorPag)) / intProdsPorPag
			If (intNumPags mod intProdsPorPag) > 0 Then intNumPags = intNumPags + 1
		
			Response.Write "<tr><td colspan=10>"
			Response.Write PaginacaoExibir(intPag, intProdsPorPag, intClientes)
			Response.Write "</td></tr>"
	
			For i = (intProdsPorPag * (intPag - 1)) to intUltima
				If i Mod 2 = 0 Then
					Response.Write "<tr>" 				
					Response.Write "<td class='classColorRelPar' align='center' width='3%'><img src='img/buscar.gif' class='imgexpandeinfo' alt='Administrar Cliente' onClick=""window.location.href = '"&URL&"/adm/frmEditCadastroCliente.asp?showclient=true&idcliente="&arrClientes(0,i)&"';""/></td>"				
					Response.Write "<td class='classColorRelPar'>"&arrClientes(1,i)&"</td>"				
					Response.Write "<td class='classColorRelPar'>"&arrClientes(2,i)&"</td>"				
					Response.Write "<td class='classColorRelPar'>"&arrClientes(20,i)&"</td>"				
					Response.Write "<td class='classColorRelPar'>"&arrClientes(22,i)&"</td>"				
					Response.Write "<td class='classColorRelPar'>"&arrClientes(3,i)&"</td>"				
					If arrClientes(17,i) = 0 Then
						Response.Write "<td class='classColorRelPar'> --- </td>"				
					ElseIf arrClientes(17,i) = 1 Then
						Response.Write "<td class='classColorRelPar'>Aprovado</td>"				
					ElseIf arrClientes(17,i) = 2 Then
						Response.Write "<td class='classColorRelPar'>Rejeitado</td>"				
					ElseIf arrClientes(17,i) = 3 Then
						Response.Write "<td class='classColorRelPar'>Inativo</td>"				
					End If	
					Response.Write "</tr>"
				Else
					Response.Write "<tr>" 				
					Response.Write "<td class='classColorRelImpar' align='center' width='3%'><img src='img/buscar.gif' class='imgexpandeinfo' alt='Administrar Cliente' onClick=""window.location.href = '"&URL&"/adm/frmEditCadastroCliente.asp?showclient=true&idcliente="&arrClientes(0,i)&"';""/></td>"				
					Response.Write "<td class='classColorRelImpar'>"&arrClientes(1,i)&"</td>"				
					Response.Write "<td class='classColorRelImpar'>"&arrClientes(2,i)&"</td>"				
					Response.Write "<td class='classColorRelImpar'>"&arrClientes(20,i)&"</td>"				
					Response.Write "<td class='classColorRelImpar'>"&arrClientes(22,i)&"</td>"				
					Response.Write "<td class='classColorRelImpar'>"&arrClientes(3,i)&"</td>"				
					If arrClientes(17,i) = 0 Then
						Response.Write "<td class='classColorRelImpar'> --- </td>"				
					ElseIf arrClientes(17,i) = 1 Then
						Response.Write "<td class='classColorRelImpar'>Aprovado</td>"				
					ElseIf arrClientes(17,i) = 2 Then
						Response.Write "<td class='classColorRelImpar'>Rejeitado</td>"				
					ElseIf arrClientes(17,i) = 3 Then
						Response.Write "<td class='classColorRelImpar'>Inativo</td>"				
					End If	
					Response.Write "</tr>"
				End If				
			Next
		Else
				Response.Write "<tr><td colspan='7' align='center' class='classColorRelPar'><b>Nenhum Cliente encontrado</b></td></tr>"
		End If						
	End Sub

	Sub GetCategories()
		Dim sSql, arrCategories, intCategories, i
		Dim sSelected
		
		sSql = "SELECT idCategorias, descricao FROM Categorias"
		
		Call search(sSql, arrCategories, intCategories)
		
		For i=0 To intCategories
			If Categoria = arrCategories(0,i) Then			
				sSelected = "selected"
			Else
				sSelected = ""
			End If
			Response.Write "<option value='"&arrCategories(0,i)&"' "&sSelected&">"&arrCategories(1,i)&"</option>"
		Next
		
	End Sub
	
	Sub GetGroups()
		Dim sSql, arrGroups, intGroups, i
		Dim sSelected
		
		sSql = "SELECT " & _
						"[idGrupos], " & _ 
						"[descricao] " & _ 
						"FROM [marketingoki2].[dbo].[Grupos]"
		Call search(sSql, arrGroups, intGroups)
		If intGroups > -1 Then
			For i=0 To intGroups
				If Grupo = arrGroups(0,i) Then
					sSelected = "selected"
				Else
					sSelected = ""
				End If	
				Response.Write "<option value='"&arrGroups(0,i)&"' "&sSelected&">"&arrGroups(1,i)&"</option>"
			Next
		End If				
	End Sub
	
	Function GetWhereClientes()
		Dim sSqlWhere
		'------------------
		sSqlWhere = ""
		
		Dim Busca
		Dim Por
		Dim Status
		Dim Categorias
		Dim sStrConcat
		
		Dim bSetBusca
		Dim bSetStatus
		
		sStrConcat = " AND "
		
		Busca 		 = Request.QueryString("search")
		Por 			 = Request.QueryString("changetype")
		Status 		 = Request.QueryString("status")
		Categorias = Request.QueryString("categoria")
		statussol  = request.QueryString("grupos")
		'------------------
		
		If Len(Busca) = 0 And CInt(Status) = -1 And CInt(Categorias) = -1 and cint(statussol) = -1 Then
			sSqlWhere = ""
		Else
			sSqlWhere = sSqlWhere & " WHERE "
		End If
		
		If Len(Busca) > 0 Then
			bSetBusca = True
			Select Case CInt(Por)
				Case 0			
					sSqlWhere = sSqlWhere & " A.[cnpj] LIKE '%"&Busca&"%' "
				Case 1
					sSqlWhere = sSqlWhere & " A.[nome_fantasia] LIKE '%"&Busca&"%' "
				Case 2
					sSqlWhere = sSqlWhere & " A.[razao_social] LIKE '%"&Busca&"%' "	
				Case -1
					sSqlWhere = sSqlWhere & " A.[cnpj] LIKE '%"&Busca&"%' OR "
					sSqlWhere = sSqlWhere & " A.[nome_fantasia] LIKE '%"&Busca&"%' AND"
					sSqlWhere = sSqlWhere & " A.[razao_social] LIKE '%"&Busca&"%' "	
			End Select	
		End If
		If CInt(Status) > -1 Then
			bSetStatus = True
			If bSetBusca Then
				sSqlWhere = sSqlWhere & sStrConcat
			End If
			sSqlWhere = sSqlWhere & " A.[status_cliente] = " & Status
		End If
		If CInt(Categorias) > -1 Then
			If bSetStatus Then
				sSqlWhere = sSqlWhere & sStrConcat
			End If
			sSqlWhere = sSqlWhere & " B.[idCategorias] = " & Categorias
		End If
		if cint(statussol) > -1 then
			If bSetStatus Then
				sSqlWhere = sSqlWhere & sStrConcat
			End If
			sSqlWhere = sSqlWhere & " C.[idGrupos] = " & statussol
		end if
		
		GetWhereClientes = sSqlWhere
		
	End Function
	
	sub getGrupos()
		dim sql, arrgrupos, intgrupos, i
		sql = "select * from grupos"
		call search(sql, arrgrupos, intgrupos)
		if intgrupos > -1 then
			for i=0 to intgrupos
				response.write "<option value="""&arrgrupos(0,i)&""">"&arrgrupos(1,i)&"</option>"
			next
		end if
	end sub	
%>
<html>
<head>
<script src="js/frmCadastroClienteAdm.js" language="javascript"></script>
<link rel="stylesheet" type="text/css" href="../css/geral.css">
<title><%=TITLE%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body <%If Request.QueryString("showclient") Then%>OnLoad="AdministraCliente()"<%End If%>>
<div id="container">
	<!--#include file="inc/i_header.asp" -->
	<div id="conteudo">
		<table cellspacing="0" cellpadding="0" width="775">
		<form action="frmCadastroClienteAdm.asp" name="frmCadastroClienteAdm" method="POST">
		<input type="hidden" name="hiddenIDCliente" value="<%=Request.QueryString("idcliente")%>" />
		<input type="hidden" name="hiddenActionIsColetaDomiciliar" value="<%=isColetaDomiciliar%>" />
		<input type="hidden" name="hiddenActionManagerProve" value="" />
		<input type="hidden" name="hiddenActionForm" value="" />
			<tr> 
				<td width="11" background="img/Bg_LatEsq.gif">&nbsp;</td>
				<td id="Td1">
					<table cellspacing="3" cellpadding="2" width="100%" border=0>
						<tr>
							<td colspan="3" id="explaintitle" align="center">Cadastros de Clientes</td>
						</tr>
						<tr>
							<td colspan="3" align="right"><a class="linkOperacional" href="javascript:window.location.href='frmOperacionalAdm.asp';">&laquo Voltar</a></td>
						</tr>
							<tr id="findcontato" valign="baseline">
								<td align="left" valign="baseline">
									Busca: <input type="text" class="text" name="txtFindCliente" size="100" value=""/>
									&nbsp;&nbsp;&nbsp;
									Por:
									<select name="typeFindCliente" class="select">
										<option value="-1">Selecione</option>
										<option value="0">CNPJ</option>
										<option value="1">Nome Fantasia</option>
										<option value="2">Raz�o Social</option>
									</select>									
									<br /><br />
									Status: 
									<select name="cbStatusFindCliente" class="select">
										<option value="-1">Todos</option>
										<option value="0">Status em branco</option>
										<option value="1">Aprovado</option>
										<option value="2">Rejeitado</option>
										<option value="3">Inativo</option>
									</select>
									&nbsp;&nbsp;
									&nbsp;&nbsp;
									Categorias: 
									<select name="cbCategoriasFindCliente" class="select">
										<option value="-1">Todas</option>
										<%Call GetCategories()%>
									</select>
								</td>
							</tr>
							<tr id="Tr1" valign="baseline">
								<td align="left" valign="baseline">
									Grupos:
									<select name="grupos" class="select">
										<option value="-1">Todos</option>
										<%call getGrupos()%>
									</select>
									&nbsp;&nbsp;
									&nbsp;&nbsp;
									<input type="button" class="btnform" name="btnFindCliente" value="Buscar" onClick="windowLocationFind('<%=URL%>')" />
								</td>
							</tr>
						<tr>
							<td colspan="3">
								<table id="tableGetClientesCadastro" cellpadding="1" cellspacing="1" width="100%">
									<tr>
										<th><img src="img/check.gif" /></th>
										<th>Raz�o Social</th>
										<th>Nome Fantasia</th>
										<th>Categoria</th>
										<th>Grupo</th>
										<th>CNPJ</th>
										<th>Status</th>
									</tr>
									<%Call GetClientes()%>
								</table>
							</td>
						</tr>
					</table>
				</td>
				<td width="11" background="img/Bg_LatDir.gif">&nbsp;</td>
			</tr>
		</form>
		</table>
	</div>
	<!--#include file="inc/i_bottom.asp" -->
</div>
</body>
</html>
<%Call close()%>
