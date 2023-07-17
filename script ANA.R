install.packages('XML') 
install.packages('tidyverse')
install.packages('writexl')

## first_import into

  library('XML')
  library('tidyverse')
  library('writexl')

data_inicio <- "01/01/2020"
data_fim <-"04/01/2020"
#tipo_dado <- "3"
#nivel_consistencia <- "1"

lista <- list("44200000","56850000") %>% unlist()
 
## dados converncionais - vazão

for (i in 1:length(lista)) {
  link <- paste0("http://telemetriaws1.ana.gov.br/ServiceANA.asmx/DadosHidrometeorologicos?",
                 "codEstacao=",lista[i],
                 "&dataInicio=",data_inicio,
                 "&dataFim=",data_fim
                 )
  link
  dados_xml <- xmlParse(link)
  df_con <- xmlToDataFrame(getNodeSet(dados_xml,
                                      "//DadosHidrometereologicos"))
  #df_con <- transform(df_con, 
                      #DataHora = as.Date(DataHora, "%Y-%m-%d %H:%M:%S"),
                      #Vazao = as.numeric(Vazao),
                      #Nivel = as.numeric(Nivel),
                      #Chuva = as.numeric(Chuva))
  df_con
  write_xlsx(df_con, paste0("C:/Temp/ANA/",
                            lista[i],
                            ".xlsx"))
  
}

