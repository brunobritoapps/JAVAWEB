<!--#include file="../_config/_config.asp" -->
<%Call open()%>
<%Call GetSessionAdm()%>
<%
	dim msgbody

	function getTransportadoras()
		dim sql, arr, intarr, i
		dim selected
		sql = "SELECT [idTransportadoras] " & _
				  ",[razao_social] " & _
				  "FROM [marketingoki2].[dbo].[Transportadoras] " & _
				  "where [status] = 1 and [iscoletaemail] = 1"
		call search(sql, arr, intarr)
		if intarr > -1 then
			for i=0 to intarr
				if cint(request.querystring("id")) = arr(0,i) then
					selected = "selected=""selected"""
				else
					selected = ""
				end if
				getTransportadoras = getTransportadoras & "<option value="""&arr(0,i)&""" "&selected&">"&arr(1,i)&"</option>"
			next
		else
			getTransportadoras = ""
		end if
	end function

	function getSolicitacaoByTransportadora(id)
		dim sql, arr, intarr, i
		dim arrponto, intponto, j

		sql = "select " & _
				"e.idtransportadoras, " & _
				"e.razao_social, " & _
				"a.numero_solicitacao_coleta, " & _
				"a.qtd_cartuchos, " & _
				"c.razao_social " & _
				"from solicitacao_coleta as a " & _
				"left join solicitacao_coleta_has_clientes as b " & _
				"on a.idsolicitacao_coleta = b.solicitacao_coleta_idsolicitacao_coleta " & _
				"left join clientes as c " & _
				"on b.clientes_idclientes = c.idclientes " & _
				"left join solicitacao_coleta_has_transportadoras as d " & _
				"on a.idsolicitacao_coleta = d.solicitacao_coleta_idsolicitacao_coleta " & _
				"left join transportadoras as e " & _
				"on d.transportadoras_idtransportadoras = e.idtransportadoras " & _
				"left join cep_consulta_has_clientes as f " & _
				"on c.idclientes = f.clientes_idclientes " & _
				"where a.status_coleta_idstatus_coleta = 2 " & _
				"and b.typecolect = 1 " & _
				"and f.isenderecocoleta = 1 " & _
				"and e.razao_social <> 'NULL' " & _
				"and e.idtransportadoras = " & id
		'Response.Write sql & "<hr>"		
		call search(sql, arr, intarr)

		sql = "select " & _
				"c.idtransp, " & _
				"c.razao_social, " & _
				"a.numero_solicitacao_coleta, " & _
				"a.qtd_cartuchos, " & _
				"c.razao_social " & _
				"from solicitacao_coleta as a " & _
				"left join solicitacao_coleta_has_pontos_coleta as b " & _
				"on a.idsolicitacao_coleta = b.solicitacao_coleta_idsolicitacao_coleta " & _
				"left join pontos_coleta as c " & _
				"on b.pontos_coleta_idpontos_coleta = c.idpontos_coleta " & _
				"left join solicitacao_coleta_has_transportadoras as d " & _
				"on a.idsolicitacao_coleta = d.solicitacao_coleta_idsolicitacao_coleta " & _
				"left join transportadoras as e " & _
				"on d.transportadoras_idtransportadoras = e.idtransportadoras " & _
				"where a.status_coleta_idstatus_coleta = 2 " & _
				"and a.ismaster = 1 " & _
				"and c.razao_social <> 'NULL' " & _
				"and c.idtransp = " & id & _
				" and left(a.numero_solicitacao_coleta,1) <> 'E'"
		'Response.Write sql & "<hr>"
		call search(sql, arrponto, intponto)
		
		dim valor
		if intarr > -1 and intponto > -1 then
			valor = intarr + intponto
		elseif intarr > -1 and not intponto > -1 then
			valor = intarr
		else
			valor = intponto
		end if
		response.write "<input type=""hidden"" name=""intsol"" value="""&valor&""" />"

		if intarr > -1 then
			dim style
			for i=0 to intarr
				if i mod 2 = 0 then
					style = "class=""classColorRelPar"""
				else
					style = "class=""classColorRelImpar"""
				end if
				getSolicitacaoByTransportadora = getSolicitacaoByTransportadora & "<tr>"
				getSolicitacaoByTransportadora = getSolicitacaoByTransportadora & "<td "&style&" width=""6%""><input type=""checkbox"" name=""idtransp"" id=""transp"&i&""" value="""&arr(2,i)&""" /> <img class=""imgexpandeinfo"" src=""img/buscar.gif"" onClick=""window.open('frmgerafiletranspanalitica.asp?id="&arr(0,i)&"&numsol="&arr(2,j)&"','','width=600,height=240,scrollbars=no,status=no,location=no,toolbar=no,menubar=no')"" /></td>"
				'getSolicitacaoByTransportadora = getSolicitacaoByTransportadora & "<td "&style&">"&arr(1,i)&"</td>"
				getSolicitacaoByTransportadora = getSolicitacaoByTransportadora & "<td "&style&">"&arr(2,i)&"</td>"
				getSolicitacaoByTransportadora = getSolicitacaoByTransportadora & "<td "&style&">"&arr(3,i)&"</td>"
				getSolicitacaoByTransportadora = getSolicitacaoByTransportadora & "<td "&style&">"&arr(4,i)&"</td>"
				getSolicitacaoByTransportadora = getSolicitacaoByTransportadora & "</tr>"
			next
		end if
		if intponto > -1 then
			for j=0 to intponto
				if j mod 2 = 0 then
					style = "class=""classColorRelPar"""
				else
					style = "class=""classColorRelImpar"""
				end if
				getSolicitacaoByTransportadora = getSolicitacaoByTransportadora & "<tr>"
				getSolicitacaoByTransportadora = getSolicitacaoByTransportadora & "<td "&style&" width=""6%""><input type=""checkbox"" name=""idtransp"" id=""transp"&j&""" value="""&arrponto(2,j)&""" /> <img class=""imgexpandeinfo"" src=""img/buscar.gif"" onClick=""window.open('frmgerafiletranspanalitica.asp?id="&arrponto(0,j)&"&numsol="&arrponto(2,j)&"','','width=600,height=240,scrollbars=no,status=no,location=no,toolbar=no,menubar=no')"" /></td>"
				'getSolicitacaoByTransportadora = getSolicitacaoByTransportadora & "<td "&style&">"&arrponto(1,j)&"</td>"
				getSolicitacaoByTransportadora = getSolicitacaoByTransportadora & "<td "&style&">"&arrponto(2,j)&"</td>"
				getSolicitacaoByTransportadora = getSolicitacaoByTransportadora & "<td "&style&">"&arrponto(3,j)&"</td>"
				getSolicitacaoByTransportadora = getSolicitacaoByTransportadora & "<td "&style&">"&arrponto(4,j)&"</td>"
				getSolicitacaoByTransportadora = getSolicitacaoByTransportadora & "</tr>"
			next
		end if
	end function

	function formataCNPJ(cnpj)
		dim retorno
		retorno = cnpj
		retorno = replace(retorno, "//","")
		retorno = replace(retorno, "/","")
		retorno = replace(retorno, "-","")
		retorno = replace(retorno, ".","")
		formataCNPJ = retorno
	end function

	function formataDataEnvio(sData)
		dim data
		data = sData
		data = replace(data,"//","")
		data = replace(data,"/","")
		formataDataEnvio = data
	end function

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

	function geraArquivo(id)
		dim solicitacoes
		dim cont_sol
		dim sql, arr, intarr, i
		dim filename_transp
		dim fso
		dim file_transp
		dim berror
		dim nomearquivo
		dim html

		berror = false

		solicitacoes = split(replace(request.form("idtransp"), " ", ""), ",")
'		for cont_sol=0 to ubound(solicitacoes)
'			response.write solicitacoes(cont_sol) & "<br />"
'		next
		if ubound(solicitacoes) > -1 then
			nomearquivo = replace(trim(getNomeTransportadora(id))," ","")&"_"&day(now())&"-"&month(now())&"-"&year(now())&"-"&fix(timer())&".txt"
			if isempty(nomearquivo) or isnull(nomearquivo) then
				nomearquivo = "TRANSPORTADORA_"&day(now())&"-"&month(now())&"-"&year(now())&"-"&fix(timer())&".txt"
			end if
			set fso = Server.Createobject("Scripting.FileSystemObject")
			filename_transp = server.MapPath("Transportadora/arquivos_gerados/"&nomearquivo)
'					response.write filename_transp
'					response.end
			set file_transp = fso.createtextfile(filename_transp)
			for cont_sol=0 to ubound(solicitacoes)
'				response.write "cont_sol: " & cont_sol & "<br />"
'				response.end
				if isMaster(solicitacoes(cont_sol)) then
					sql = "select " & _
							"e.idtransportadoras, " & _
							"e.razao_social, " & _
							"a.numero_solicitacao_coleta, " & _
							"a.data_envio_transportadora, " & _
							"a.qtd_cartuchos, " & _
							"c.razao_social, " & _
							"c.logradouro, " & _
							"c.numero_endereco, " & _
							"c.bairro, " & _
							"c.cep, " & _
							"c.municipio, " & _
							"c.estado, " & _
							"c.cnpj, " & _
							"c.complemento_endereco, " & _
							"e.contato, " & _
							"e.telefone, " & _
							"e.ddd, " & _
							"c.nome_fantasia, " & _
							"c.usuario, " & _
							"c.ddd, " & _
							"c.telefone " & _
							"from solicitacao_coleta as a " & _
							"left join solicitacao_coleta_has_pontos_coleta as b " & _
							"on a.idsolicitacao_coleta = b.solicitacao_coleta_idsolicitacao_coleta " & _
							"left join pontos_coleta as c " & _
							"on b.pontos_coleta_idpontos_coleta = c.idpontos_coleta " & _
							"left join solicitacao_coleta_has_transportadoras as d " & _
							"on a.idsolicitacao_coleta = d.solicitacao_coleta_idsolicitacao_coleta " & _
							"left join transportadoras as e " & _
							"on d.transportadoras_idtransportadoras = e.idtransportadoras " & _
							"where a.status_coleta_idstatus_coleta = 2 " & _
							"and a.ismaster = 1 " & _
							"and c.razao_social <> 'NULL' " & _
							"and a.numero_solicitacao_coleta = '"&solicitacoes(cont_sol)&"' " & _
							"and c.idtransp = " & id
				else
					sql = "select " & _
							"e.idtransportadoras, " & _
							"e.razao_social, " & _
							"a.numero_solicitacao_coleta, " & _
							"a.data_envio_transportadora, " & _
							"a.qtd_cartuchos, " & _
							"c.razao_social, " & _
							"f.logradouro, " & _
							"c.numero_endereco_coleta, " & _
							"f.bairro, " & _
							"f.cep, " & _
							"f.municipio, " & _
							"f.estado, " & _
							"b.contato_coleta, " & _
							"b.ddd_resp_coleta, " & _
							"b.telefone_resp_coleta, " & _
							"c.cnpj, " & _
							"c.compl_endereco_coleta " & _
							"from solicitacao_coleta as a " & _
							"left join solicitacao_coleta_has_clientes as b " & _
							"on a.idsolicitacao_coleta = b.solicitacao_coleta_idsolicitacao_coleta " & _
							"left join clientes as c " & _
							"on b.clientes_idclientes = c.idclientes " & _
							"left join solicitacao_coleta_has_transportadoras as d " & _
							"on a.idsolicitacao_coleta = d.solicitacao_coleta_idsolicitacao_coleta " & _
							"left join transportadoras as e " & _
							"on d.transportadoras_idtransportadoras = e.idtransportadoras " & _
							"left join cep_consulta_has_clientes as f " & _
							"on c.idclientes = f.clientes_idclientes " & _
							"where a.status_coleta_idstatus_coleta = 2 " & _
							"and b.typecolect = 1 " & _
							"and f.isenderecocoleta = 1 " & _
							"and e.razao_social <> 'NULL' " & _
							"and a.numero_solicitacao_coleta = '"&solicitacoes(cont_sol)&"' " & _
							"and e.idtransportadoras = " & id
				end if

'				response.write "sql: " & sql & "<br />"
'				response.end
				call search(sql, arr, intarr)
				if intarr > -1 then
'					response.write "intarr: " & intarr & "<br />"
					dim line
					for i=0 to intarr
						if isMaster(solicitacoes(cont_sol)) then
							line = formataCNPJ(trim(arr(12,i)))&";"&trim(arr(1,i))&";"&trim(arr(2,i))&";"&formataDataEnvio(DateRight(formatdatetime(now(),2)))&";"&trim(arr(4,i))&";"&trim(arr(5,i))&";"&trim(arr(6,i))&";"&trim(arr(7,i))&";"&trim(arr(8,i))&";"&trim(arr(9,i))&";"&trim(arr(10,i))&";"&trim(arr(11,i))&";"&trim(arr(17,i))&";"&trim(arr(18,i))&";"&trim(arr(19,i))&";"&trim(arr(20,i))&";#"
							html = html & "<div align=""left"">"
							html = html & "<div align=""left""><b>N� de Solicita��o:</b> " & arr(2,i) & "</div>"
							html = html & "<div align=""left""><b>Raz�o Social:</b> " & arr(5,i) & "</div>"
							html = html & "<div align=""left""><b>CNPJ:</b> " & formataCNPJ(trim(arr(12,i))) & "</div>"
							html = html & "<div align=""left""><b>Endere�o:</b> " & arr(6,i) & "," & arr(7,i) & "</div>"
							html = html & "<div align=""left""><b>Complemento:</b> " & arr(13,i) & "</div>"
							html = html & "<div align=""left""><b>Bairro:</b> " & arr(8,i) & "</div>"
							html = html & "<div align=""left""><b>Cidade:</b> " & arr(10,i) & "</div>"
							html = html & "<div align=""left""><b>UF:</b> " & arr(11,i) & "</div>"
							html = html & "<div align=""left""><b>Contato:</b> " & arr(14,i) & "</div>"
							html = html & "<div align=""left""><b>Telefone:</b> " & arr(16,i) & " - " & arr(15,i) & "</div>"
							html = html & "<div align=""left""><b>Quantidade de cartuchos:</b> " & arr(4,i) & "</div>"
							
							'html = html & "<div align=""left""><b>Ponto de Coleta:</b> " & arr(17,i) & "</div>"
							html = html & "<div align=""left""><b>Contato:</b> " & arr(18,i) & "</div>"
							html = html & "<div align=""left""><b>Telefone:</b> " & arr(19,i) & " - " & arr(20,i) & "</div>"
							
							html = html & "<div align=""left""><b>Por favor informar n� do conhecimento e data prov�vel de retirada.</b></div>"
							html = html & "<br /><br />"
							html = html & "</div>"
						else
							line = formataCNPJ(trim(arr(15,i)))&";"&trim(arr(1,i))&";"&trim(arr(2,i))&";"&formataDataEnvio(DateRight(formatdatetime(now(),2)))&";"&trim(arr(4,i))&";"&trim(arr(5,i))&";"&trim(arr(6,i))&";"&trim(arr(7,i))&";"&trim(arr(8,i))&";"&trim(arr(9,i))&";"&trim(arr(10,i))&";"&trim(arr(11,i))&";"&trim(arr(12,i))&";"&trim(arr(13,i))&";"&trim(arr(14,i))&";#"
							html = html & "<div align=""left"">"
							html = html & "<div align=""left""><b>N� de Solicita��o:</b> " & arr(2,i) & "</div>"
							html = html & "<div align=""left""><b>Raz�o Social:</b> " & arr(5,i) & "</div>"
							html = html & "<div align=""left""><b>CNPJ:</b> " & formataCNPJ(trim(arr(15,i))) & "</div>"
							html = html & "<div align=""left""><b>Endere�o:</b> " & arr(6,i) & "," & arr(7,i) & "</div>"
							html = html & "<div align=""left""><b>Complemento:</b> " & arr(16,i) & "</div>"
							html = html & "<div align=""left""><b>Bairro:</b> " & arr(8,i) & "</div>"
							html = html & "<div align=""left""><b>Cidade:</b> " & arr(10,i) & "</div>"
							html = html & "<div align=""left""><b>UF:</b> " & arr(11,i) & "</div>"
							html = html & "<div align=""left""><b>Contato:</b> " & arr(12,i) & "</div>"
							html = html & "<div align=""left""><b>Telefone:</b> " & arr(13,i) & " - " & arr(14,i) & " </div>"
							html = html & "<div align=""left""><b>Quantidade de cartuchos:</b> " & arr(4,i) & "</div>"
							html = html & "<div align=""left""><b>Por favor informar n� do conhecimento e data prov�vel de retirada.</b></div>"
							html = html & "<br /><br />"
							html = html & "</div>"
						end if
						html = html & "<hr />"
'						response.write "line: " & line & "<br />"
						file_transp.writeLine(line)
					next
					call atualizaSolicitacao(solicitacoes(cont_sol))
				else
					berror = true
				end if
			next
'			response.end
			set file_transp = nothing
			dim file_get
			dim path_file
			'path_file = request.servervariables("APPL_PHYSICAL_PATH") & "adm/Transportadora/arquivos_gerados/"&nomearquivo
			path_file = server.MapPath("Transportadora/arquivos_gerados/"&nomearquivo)
			set file_get = fso.getfile(path_file)
			call EnviarEmail(getEmailTransp(id), file_get, html)
			set file_get = nothing
			set fylesystem = nothing
		else
			berror = true
		end if

		if berror then
			geraArquivo = false
		else
			geraArquivo = true
		end if
	end function

	sub atualizaSolicitacao(num)
		dim sql
		dim data
		data = Year(Now()) & "/" & Month(Now()) & "/" & Day(Now())
		sql = "update solicitacao_coleta set data_envio_transportadora = CONVERT(DATETIME, '"&data&"'), status_coleta_idstatus_coleta = 5 where numero_solicitacao_coleta = '"&num&"'"
'		response.write sql
'		response.end
		call exec(sql)
	end sub

	function getEmailTransp(id)
		dim sql, arr, intarr, i
		sql = "SELECT " & _
						"[email] " & _
						"FROM [marketingoki2].[dbo].[Transportadoras] " & _
						"where [isColetaEmail] = 1 and [idTransportadoras] = "&id&" and [status] = 1"
		call search(sql, arr, intarr)
		if intarr > -1 then
			getEmailTransp = arr(0,i)
		else
			getEmailTransp = ""
		end if
	end function

	function isMaster(id)
		dim sql, arr, intarr, i
		sql = "select ismaster from solicitacao_coleta where numero_solicitacao_coleta = '"&id&"'"
		call search(sql, arr, intarr)
		if intarr > -1 then
			for i=0 to intarr
				if cint(arr(0,i)) = 0 then
					isMaster = false
				else
					isMaster = true
				end if
			next
		end if
	end function

	function getNomeTransportadora(id)
		dim sql, arr, intarr, i
		sql = "select razao_social from transportadoras where idtransportadoras = " & id
		call search(sql, arr, intarr)
		if intarr > -1 then
			for i=0 to intarr
				getNomeTransportadora = arr(0,i)
			next
		else
		end if
	end function

	Sub EnviarEmail(Destino, Arquivo, html_solicitacoes)

		Dim MsgBody

		MsgBody = "<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.0 Transitional//EN"" ""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd""> " & _
							"<html xmlns=""http://www.w3.org/1999/xhtml""> " & _
							"<head> " & _
							"<meta http-equiv=""Content-Type"" content=""text/html; charset=iso-8859-1"" /> " & _
							"<title>Email Okidata</title> " & _
							"</head> " & _
							"<body> " & _
								"<div id=""container"" align=""center""> " & _
									"<div id=""bottom"" style=""font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10px;width:748px;""> " & _
										"Prezado transportador; " & _
										"<br />	" & _
										"Por gentileza efetuar o agendamento da coleta, em hor�rio comercial, no(s) " & _
										"seguinte(s) cliente(s): <br /><br />" & _
										"" &html_solicitacoes& "" & _
										"�rico Tooru Tanji<br /> " & _
										"Opera��es - Log�stica Reversa/Suprimentos<br /> " & _
										"Oki Data do Brasil Inf. Ltda.<br /> " & _
										"Tel: +55(11) 3444-3574<br /> " & _
										"Fax: +55(11) 3444-3502<br /> " & _
										"sustentabilidadeoki@okidata.com.br<br /> " & _
										"www.okiprintingsolutions.com<br /> " & _
										"<p><b>CONFIDENCIALIDADE DO CORREIO ELETR�NICO</b> " & _
										"Esta mensagem, incluindo seus anexos, pode conter informa��o confidencial " & _
										"e/ou privilegiada. Caso voc� tenha recebido este e-mail por engano, n�o " & _
										"utilize, copie ou divulgue as informa��es nele contidas. E, por favor, avise " & _
										"imediatamente o remetente, respondendo ao e-mail, e em seguida apague-o.</p> " & _
										"<p><b>DISCLAIMER</b> " & _
										"This message, including its attachments, may contain confidential and/or " & _
										"privileged information. If you received this email by mistake, do not use, " & _
										"copy or disseminate any information here in contained. Please notify us " & _
										"immediately by replying to the sender and then delete it.</p> " & _
									"</div> " & _
								"</div> " & _
							"</body> " & _
							"</html>"

'		response.write MsgBody
'		response.end

		'If Left(Request.ServerVariables("LOCAL_ADDR"), 3) = "192" or Left(Request.ServerVariables("LOCAL_ADDR"), 3) = "127" Then
		'	Dim EnviarMail

		'	Set EnviarMail = Server.CreateObject("CDONTS.NewMail")
		'	EnviarMail.From = "sustentabilidadeoki@okidata.com.br"
		'	EnviarMail.Subject = "Sistema de Gerenciamento de retorno de suprimentos"
		'	EnviarMail.To = Destino
		'	EnviarMail.Body = MsgBody
		'	EnviarMail.Importance = 1
		'	EnviarMail.BodyFormat = 0
		'	EnviarMail.MailFormat = 0
		'	EnviarMail.Attachfile Arquivo
		'	EnviarMail.Send
		'	Set EnviarMail = Nothing
		'Else
			Dim objCDOSYSMail
			Dim objCDOSYSCon
			'CRIA A INST�NCIA COM O OBJETO CDOSYS
			Set objCDOSYSMail = Server.CreateObject("CDO.Message")

			'CRIA A INST�NCIA DO OBJETO PARA CONFIGURA��O DO SMTP
			Set objCDOSYSCon = Server.CreateObject ("CDO.Configuration")

			'SERVIDOR DE SMTP, USE smtp.SeuDominio.com OU smtp.hostsys.com.br
			'objCDOSYSCon.Fields http://schemas.microsoft.com/cdo/configuration/smtpserver") = "174.37.245.58"
			objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.sustentabilidadeoki.com.br

			objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/sendusername") = "sustentabilidadeoki@sustentabilidadeoki.com.br" 'Email
			objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "Oki!321!"        'senha
		
("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
	
			'PORTA PARA COMUNICA��O COM O SERVI�O DE SMTP
			objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 587

			'PORTA DO CDO
			objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/sendusing") = 1

			'TEMPO DE TIMEOUT (EM SEGUNDOS)
			objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 30

			'ATUALIZA A CONFIGURA��O DO CDOSYS PARA ENVIO DO E-MAIL
			objCDOSYSCon.Fields.update
			Set objCDOSYSMail.Configuration = objCDOSYSCon

			'NOME DO REMETENTE, E-MAIL DO REMETENTE
			objCDOSYSMail.From = "OKI <sustentabilidadeoki@sustentabilidadeoki.com.br>"
			'objCDOSYSMail.From = "sustentabilidadeoki@sustentabilidadeoki.com.br"
			
			'NOME DO DESINAT�RIO, E-MAIL DO DESINAT�RIO
			objCDOSYSMail.To = Destino

			objCDOSYSMail.AddAttachment(Arquivo)

			'ASSUNTO DA MENSAGEM
			objCDOSYSMail.Subject = "Okidata - Sistema de Gerenciamento de Recolhimento de Suprimentos"

			'CONTE�DO DA MENSAGEM
			'objCDOSYSMail.TextBody = "Teste do componente CDOSYS"
			'PARA ENVIO DA MENSAGEM NO FORMATO HTML, ALTERE O TextBody PARA HtmlBody
			objCDOSYSMail.HtmlBody = MsgBody

			'ENVIA A MENSAGEM
			objCDOSYSMail.Send

			'DESTR�I OS OBJETOS
			Set objCDOSYSMail = Nothing
			Set objCDOSYSCon = Nothing
		'End If
	End Sub


	if request.servervariables("HTTP_METHOD") = "POST" then
		if geraArquivo(request.form("id")) then
			response.write "<script>alert('Arquivo gerado com sucesso')</script>"
		else
			response.write "<script>alert('Arquivo n�o pode ser gerado')</script>"
		end if
	end if
%>
<html>
<head>
<script>
	function redirTransp() {
		window.location = 'frmgerafiletransp.asp?id='+document.frmgerafiletransp.cbTransp.value;
	}

	function checkAll() {
		if (parseInt(document.frmgerafiletransp.intsol.value) > -1) {
			if (document.frmgerafiletransp.checkall.checked) {
				for (var i=0; i <= parseInt(document.frmgerafiletransp.intsol.value); i++) {
					var id = "transp"+i;
					document.getElementById(id).checked = true;
				}
			} else {
				for (var i=0; i <= parseInt(document.frmgerafiletransp.intsol.value); i++) {
					var id = "transp"+i;
					document.getElementById(id).checked = false;
				}
			}
		}
	}
</script>
<link rel="stylesheet" type="text/css" href="../css/geral.css">
<title><%=TITLE%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<div id="container">
	<!--#include file="inc/i_header.asp" -->
	<div id="conteudo">
		<table cellspacing="0" cellpadding="0" width="775">
		<form action="frmgerafiletransp.asp" name="frmgerafiletransp" method="POST">
			<input type="hidden" name="id" value="<%=request.querystring("id")%>" />
			<tr>
				<td width="11" background="img/Bg_LatEsq.gif">&nbsp;</td>
				<td id="conteudo">
					<table cellpadding="1" cellspacing="1" width="100%" id="tableprodcad">
						<tr>
							<td colspan="12" id="explaintitle" align="center">Gera Arquivo Eletr�nico para Transportadora</td>
						</tr>
						<tr>
							<td colspan="12" align="right"><a class="linkOperacional" href="javascript:window.location.href='frmOperacionalAdm.asp';">&laquo Voltar</a></td>
						</tr>
						<tr>
							<td align="right">Transportadora:</td>
							<td align="left">
								<select name="cbTransp" class="select" style="width:200px;" onChange="redirTransp()">
									<option value="-1">[Selecione]</option>
									<%=getTransportadoras()%>
								</select>
								<img src="img/transportadoras.gif" class="imgexpandeinfo" width="25" height="25" align="absmiddle" alt="Buscar Transportadora" onClick="window.open('frmsearchtranspgetfile.asp','','width=410,height=300,scrollbars=no,status=no,location=no,toolbar=no,menubar=no')" />
							</td>
						</tr>
						<tr>
							<td colspan="12">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="12">
								<table cellpadding="1" cellspacing="1" width="100%" id="tableGetClientesCadastro">
									<%if request.querystring("id") <> "" and cint(request.querystring("id")) <> -1 then%>
										<tr>
											<td colspan="5" id="explaintitle">
												<input type="checkbox" name="checkall" value="true" onClick="checkAll()" /> Selecionar Todos
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<input type="submit" name="action" class="btnform" value="Gerar Arquivo" />
											</td>
										</tr>
									<%end if%>
									<tr>
										<th><img src="img/check.gif" /></th>
										<!--<th>Raz�o Social Transp.</th>-->
										<th>N� Sol.</th>
										<th>Qtd. Prod.</th>
										<th>Raz�o Social Cliente</th>
										<%if request.querystring("id") <> "" and cint(request.querystring("id")) <> -1 then%>
										<%=getSolicitacaoByTransportadora(request.querystring("id"))%>
										<%end if%>
									</tr>
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
