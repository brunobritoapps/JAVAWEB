<!--#include file="../_config/_config.asp" -->
<%Call open()%>
<%Call GetSessionAdm()%>
<%
	Sub getSolicitacoesColeta()
		Dim sSql, arrSolColeta, intSolColeta, i

		If Request.QueryString("busca") <> "" Then
			sSql = "SELECT " & _ 
							"[A].[idSolicitacao_coleta], " & _
							"[A].[numero_solicitacao_coleta], " & _ 
							"[A].[qtd_cartuchos], " & _ 
							"[A].[data_recebimento], " & _ 
							"[A].[motivo_status], " & _ 
							"[A].[isMaster], " & _
							"[C].[nome_fantasia], " & _
							"[C].[typeColect], " & _
							"[B].[typeColect], " & _
							"[A].[status_coleta_idstatus_coleta], " & _
							"[d].[status_coleta], " & _
							"[C].[tipopessoa] " & _
							"FROM [marketingoki2].[dbo].[Solicitacao_coleta] AS [A] " & _ 
							"LEFT JOIN [marketingoki2].[dbo].[Solicitacao_coleta_has_Clientes] AS [B] " & _ 
							"ON [A].[idSolicitacao_coleta] = [B].[Solicitacao_coleta_idSolicitacao_coleta] " & _ 
							"LEFT JOIN [marketingoki2].[dbo].[Clientes] AS [C] " & _
							"ON [B].[Clientes_idClientes] = [C].[idClientes] " & _
							"left join [marketingoki2].[dbo].[status_coleta] as [d] " & _
							"on [A].[status_coleta_idstatus_coleta] = [d].[idstatus_coleta] " & _
							"WHERE [B].[typeColect] = 0 AND [A].[numero_solicitacao_coleta] = '"&Request.QueryString("busca")&"'"
		Else					
			If CInt(Request.QueryString("StatusSol")) = 0 And CInt(Request.QueryString("TypeColect")) = 0 Then
				sSql = "SELECT " & _ 
								"[A].[idSolicitacao_coleta], " & _
								"[A].[numero_solicitacao_coleta], " & _ 
								"[A].[qtd_cartuchos], " & _ 
								"[A].[data_recebimento], " & _ 
								"[A].[motivo_status], " & _ 
								"[A].[isMaster], " & _
								"[C].[nome_fantasia], " & _
								"[C].[typeColect], " & _
								"[B].[typeColect], " & _
								"[A].[status_coleta_idstatus_coleta], " & _
								"[d].[status_coleta], " & _
								"[C].[tipopessoa] " & _
								"FROM [marketingoki2].[dbo].[Solicitacao_coleta] AS [A] " & _ 
								"LEFT JOIN [marketingoki2].[dbo].[Solicitacao_coleta_has_Clientes] AS [B] " & _ 
								"ON [A].[idSolicitacao_coleta] = [B].[Solicitacao_coleta_idSolicitacao_coleta] " & _ 
								"LEFT JOIN [marketingoki2].[dbo].[Clientes] AS [C] " & _
								"ON [B].[Clientes_idClientes] = [C].[idClientes] " & _
								"left join [marketingoki2].[dbo].[status_coleta] as [d] " & _
								"on [A].[status_coleta_idstatus_coleta] = [d].[idstatus_coleta] " & _
								"WHERE [B].[typeColect] = 0"
			Else
				If CInt(Request.QueryString("StatusSol")) > 0 And CInt(Request.QueryString("TypeColect")) = 0 Then
					sSql = "SELECT " & _ 
									"[A].[idSolicitacao_coleta], " & _
									"[A].[numero_solicitacao_coleta], " & _ 
									"[A].[qtd_cartuchos], " & _ 
									"[A].[data_recebimento], " & _ 
									"[A].[motivo_status], " & _ 
									"[A].[isMaster], " & _
									"[C].[nome_fantasia], " & _
									"[C].[typeColect], " & _
									"[B].[typeColect], " & _
									"[A].[status_coleta_idstatus_coleta], " & _
									"[d].[status_coleta], " & _
									"[C].[tipopessoa] " & _
									"FROM [marketingoki2].[dbo].[Solicitacao_coleta] AS [A] " & _ 
									"LEFT JOIN [marketingoki2].[dbo].[Solicitacao_coleta_has_Clientes] AS [B] " & _ 
									"ON [A].[idSolicitacao_coleta] = [B].[Solicitacao_coleta_idSolicitacao_coleta] " & _ 
									"LEFT JOIN [marketingoki2].[dbo].[Clientes] AS [C] " & _
									"ON [B].[Clientes_idClientes] = [C].[idClientes] " & _ 
									"left join [marketingoki2].[dbo].[status_coleta] as [d] " & _
									"on [A].[status_coleta_idstatus_coleta] = [d].[idstatus_coleta] " & _
									"WHERE [B].[typeColect] = 0 AND " & _
									"[A].[Status_coleta_idStatus_coleta] = " & Request.QueryString("StatusSol")
				ElseIf CInt(Request.QueryString("StatusSol")) = 0 And CInt(Request.QueryString("TypeColect")) > 0 Then					
					sSql = "SELECT " & _ 
									"[A].[idSolicitacao_coleta], " & _
									"[A].[numero_solicitacao_coleta], " & _ 
									"[A].[qtd_cartuchos], " & _ 
									"[A].[data_recebimento], " & _ 
									"[A].[motivo_status], " & _ 
									"[A].[isMaster], " & _
									"[C].[nome_fantasia], " & _
									"[C].[typeColect], " & _
									"[B].[typeColect], " & _
									"[A].[status_coleta_idstatus_coleta], " & _
									"[d].[status_coleta], " & _
									"[C].[tipopessoa] " & _
									"FROM [marketingoki2].[dbo].[Solicitacao_coleta] AS [A] " & _ 
									"LEFT JOIN [marketingoki2].[dbo].[Solicitacao_coleta_has_Clientes] AS [B] " & _ 
									"ON [A].[idSolicitacao_coleta] = [B].[Solicitacao_coleta_idSolicitacao_coleta] " & _ 
									"LEFT JOIN [marketingoki2].[dbo].[Clientes] AS [C] " & _
									"ON [B].[Clientes_idClientes] = [C].[idClientes] " & _ 
									"left join [marketingoki2].[dbo].[status_coleta] as [d] " & _
									"on [A].[status_coleta_idstatus_coleta] = [d].[idstatus_coleta] " & _
									"WHERE [B].[typeColect] = 0 AND " & _
									"[C].[Categorias_idCategorias] = " & Request.QueryString("TypeColect")
				Else
					sSql = "SELECT " & _ 
									"[A].[idSolicitacao_coleta], " & _
									"[A].[numero_solicitacao_coleta], " & _ 
									"[A].[qtd_cartuchos], " & _ 
									"[A].[data_recebimento], " & _ 
									"[A].[motivo_status], " & _ 
									"[A].[isMaster], " & _
									"[C].[nome_fantasia], " & _
									"[C].[typeColect], " & _
									"[B].[typeColect], " & _
									"[A].[status_coleta_idstatus_coleta], " & _
									"[d].[status_coleta], " & _
									"[C].[tipopessoa] " & _
									"FROM [marketingoki2].[dbo].[Solicitacao_coleta] AS [A] " & _ 
									"LEFT JOIN [marketingoki2].[dbo].[Solicitacao_coleta_has_Clientes] AS [B] " & _ 
									"ON [A].[idSolicitacao_coleta] = [B].[Solicitacao_coleta_idSolicitacao_coleta] " & _ 
									"LEFT JOIN [marketingoki2].[dbo].[Clientes] AS [C] " & _
									"ON [B].[Clientes_idClientes] = [C].[idClientes] " & _ 
									"left join [marketingoki2].[dbo].[status_coleta] as [d] " & _
									"on [A].[status_coleta_idstatus_coleta] = [d].[idstatus_coleta] " & _
									"WHERE [B].[typeColect] = 0 AND " & _
									"[A].[Status_coleta_idStatus_coleta] = " & Request.QueryString("StatusSol") & _
									" AND [C].[Categorias_idCategorias] = " & Request.QueryString("TypeColect")
				End If							
			End If
		End if	
		
		Call search(sSql, arrSolColeta, intSolColeta)
		
		With Response	
			If intSolColeta > -1 Then
				'PAGINACAO NOVA - JADILSON
				Dim intUltima, _
				    intNumProds, _
						intProdsPorPag, _
						intNumPags, _
						intPag, _
						intPorLinha

				intProdsPorPag = 30 'numero de registros mostrados na pagina
				intNumProds = intSolColeta+1 'numero total de registros
			
				intPag = CInt(Request("pg")) 'pagina atual da paginacao
				If intPag <= 0 Then intPag = 1
				if request.ServerVariables("HTTP_METHOD") = "POST" then	intPag=1
			
				intUltima   = intProdsPorPag * intPag - 1
				If intUltima > (intNumProds - 1) Then intUltima = (intNumProds - 1)
					
				intNumPags = (intNumProds - (intNumProds mod intProdsPorPag)) / intProdsPorPag
				If (intNumPags mod intProdsPorPag) > 0 Then intNumPags = intNumPags + 1
		
				.Write "<tr><td colspan=9><div id=pag>"
				.Write PaginacaoExibir(intPag, intProdsPorPag, intSolColeta)
				.Write "</div></td></tr>"
			
				For i = (intProdsPorPag * (intPag - 1)) to intUltima
					If i Mod 2 = 0 Then
						.Write "<tr>"
						.Write "<td width='1%' align='left' class='classColorRelPar'><img class='imgexpandeinfo' src='img/buscar.gif' alt='Verificar Solicita��o de Coleta' onClick=""javascript:window.open('frmEditSolicitacaoColetaPontoColetaAdm.asp?iscoletadomiciliar="&arrSolColeta(8,i)&"&idsolic="&arrSolColeta(0,i)&"&tipopessoa="&arrSolColeta(11,i)&"','','width=500,height=650,scrollbars=no,status=no,location=no,toolbar=no,menubar=no');"" ></td>"
						.Write 	"<td class='classColorRelPar' align='left'>"&arrSolColeta(6,i)&"</td>"
						.Write 	"<td width='15%' class='classColorRelPar' align='left'>"&arrSolColeta(1,i)&"</td>"
						If IsNull(arrSolColeta(3,i)) Then
							.Write	"<td align='left' width='15%' class='classColorRelPar'>##/##/####</td>"
						Else
							.Write	"<td class='classColorRelPar'>"&DateRight(arrSolColeta(3,i))&"</td>"
						End If
						.Write	"<td class='classColorRelPar'  width='15%' align='right'>"&arrSolColeta(2,i)&"</td>"
						.write "<td class='classColorRelPar'  width='15%' align='left'>"&arrSolColeta(10,i)&"</td>"
						.Write "</tr>"
					Else
						.Write "<tr>"
						.Write "<td width='1%' align='left' class='classColorRelImpar'><img class='imgexpandeinfo' src='img/buscar.gif' alt='Verificar Solicita��o de Coleta' onClick=""javascript:window.open('frmEditSolicitacaoColetaPontoColetaAdm.asp?iscoletadomiciliar="&arrSolColeta(8,i)&"&idsolic="&arrSolColeta(0,i)&"&tipopessoa="&arrSolColeta(11,i)&"','','width=500,height=650,scrollbars=no,status=no,location=no,toolbar=no,menubar=no');"" ></td>"
						.Write 	"<td class='classColorRelImpar' align='left'>"&arrSolColeta(6,i)&"</td>"
						.Write 	"<td width='15%' class='classColorRelImpar' align='left'>"&arrSolColeta(1,i)&"</td>"
						If IsNull(arrSolColeta(3,i)) Then
							.Write	"<td align='left' width='15%' class='classColorRelImpar'>##/##/####</td>"
						Else
							.Write	"<td class='classColorRelImpar'>"&DateRight(arrSolColeta(3,i))&"</td>"
						End If
						.Write "<td class='classColorRelImpar'  width='15%' align='right'>"&arrSolColeta(2,i)&"</td>"
						.write "<td class='classColorRelImpar'  width='15%' align='left'>"&arrSolColeta(10,i)&"</td>"
						.Write "</tr>"
					End If
				Next
				.Write "<tr><td colspan=9><div id=pag>"
				.Write PaginacaoExibir(intPag, intProdsPorPag, intSolColeta)
				.Write "</div></td></tr>"
			Else
				.Write "<tr>"					
				.Write	"<td colspan='6' align='center' class='classColorRelPar'><b>Nenhum Solicita��o Encontrada</b></td>"
				.Write "</tr>"
			End If
		End With
	End Sub

	Sub getStatusColeta()
		Dim sSql, arrStatus, intStatus, i
		Dim sSelected
		sSql = "SELECT " & _
						"[idStatus_coleta], " & _
						"[status_coleta] " & _ 
						"FROM [marketingoki2].[dbo].[Status_coleta]"
		Call search(sSql, arrStatus, intStatus)
		With Response
			If intStatus > -1 Then
				For i=0 To intStatus
					If Request.QueryString("StatusSol") = CStr(arrStatus(0,i)) Then
						sSelected = "selected"
					Else
						sSelected = ""
					End If
					.Write "<option value='"&arrStatus(0,i)&"' "&sSelected&">"&arrStatus(1,i)&"</option>"					
				Next
			End If
		End With
	End Sub
	
	Sub GetColectType()
		Dim sSql, arrType, intType, i
		Dim sSelected
		
		sSql = "SELECT " & _ 
						"[idCategorias], " & _ 
						"[descricao] " & _
						"FROM [marketingoki2].[dbo].[Categorias] " & _
						"WHERE [ativo] = 1"

		Call search(sSql, arrType, intType)				
		
		If intType > -1 Then
			With Response
				For i=0 To intType
					If Request.QueryString("TypeColect") = CStr(arrType(0,i)) Then
						sSelected = "selected"
					Else
						sSelected = ""
					End If
					.Write "<option value='"&arrType(0,i)&"' "&sSelected&">"&arrType(1,i)&"</option>"															
				Next
			End With
		End If
	End Sub
	
	Function DateRight(sData)
		Dim Dia
		Dim Mes
		Dim Ano
		
		Dia = Left(sData, 2)
		Dia = Replace(Dia, "/", "")
		If Len(Dia) = 1 Then
			Dia = "0" & Dia
		End If
		If Len(Replace(Left(sData, 2), "/", "")) = 1 Then
			Mes = Mid(sData, 3, 2)
			Mes = Replace(Mes, "/", "")	
			If Len(Mes) = 1 Then
				Mes = "0" & Mes
			End If	
		Else 
			Mes = Mid(sData, 4, 2)
			Mes = Replace(Mes, "/", "")	
			If Len(Mes) = 1 Then
				Mes = "0" & Mes
			End If	
		End If
		Ano = Right(sData, 4)
		Ano = Replace(Ano, "/", "")
		If Len(Ano) = 1 Then
			Ano = "0" & Ano
		End If
		DateRight = Mes & "/" & Dia & "/" & Ano
	End Function

%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/geral.css">
<title><%=TITLE%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<div id="container">
	<!--#include file="inc/i_header.asp" -->
	<div id="conteudo">
		<table cellspacing="0" cellpadding="0" width="775">
		<form action="frmOperacionalAdm.asp" name="frmOperacionalAdm" method="POST">
			<tr> 
				<td width="11" background="img/Bg_LatEsq.gif">&nbsp;</td>
				<td id="conteudo">
					<table cellpadding="3" cellspacing="0" width="100%">
						<tr>
							<td colspan="4" align="right"><a class="linkOperacional" href="javascript:window.location.href='frmOperacionalAdm.asp';">&laquo Voltar</a></td>
						</tr>
						<tr>
							<td colspan="4" id="explaintitle" align="left">
								N�mero Solicita��o: <input type="text" name="busca" class="text" value="<%= request.querystring("busca") %>" size="40" />
								<input type="button" name="btnprocurar" value="Procurar" class="btnform" onClick="window.location.href='frmSolicitacoesAdmPonto.asp?busca=' + document.frmOperacionalAdm.busca.value + ''" />
							</td>
						</tr>
						<tr>
							<td colspan="4" id="explaintitle" align="left">
								Status : 
								<select name="cbStatusColeta" class="select" onChange="window.location.href='frmSolicitacoesAdmPonto.asp?StatusSol=' + this.value + '&TypeColect=' + document.frmOperacionalAdm.cbTipoColeta.value;">
									<option value="0">Todas</option>
									<%Call getStatusColeta()%>
								</select>
								&nbsp;&nbsp;&nbsp;	
								Categoria : 
								<select name="cbTipoColeta" class="select" onChange="window.location.href='frmSolicitacoesAdmPonto.asp?TypeColect=' + this.value + '&StatusSol=' + document.frmOperacionalAdm.cbStatusColeta.value;">
									<option value="0">Todas</option>
									<%Call GetColectType()%>
								</select>	
							</td>
						</tr>
						<tr>
							<td colspan="5">
								<table cellpadding="1" cellspacing="1" width="100%" align="center" id="tableRelSolPendente">
									<tr>
										<th><img src="img/check.gif" /></th>
										<th>Nome Fantasia</th>
										<th>N� Solicita��o</th>
										<th>DT. Recebimento</th>
										<th>Quantidade</th>
										<th>Status</th>
									</tr>
									<%Call getSolicitacoesColeta()%>
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
