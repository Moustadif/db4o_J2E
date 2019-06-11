<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="ensak.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Livres écrits par un auteur donné</title>
<style type="text/css">
body,td,th {
font-family: Trebuchet MS;
font-size: 16px;
}
</style>
</head>
<body>
<h3>Livres écrits par un auteur donné</h3>
<jsp:useBean id="dao" class="ensak.DAO"/>
<%
// Ouverture de la base de données objets
dao.open();
String[] informationsAuteurs = dao.getListeAuteurs();
%>
<form name="essayerFrm" action="${request.requestURI}" method="post">
<p><select name="mnuAuteurs">
<%
for (int i = 0; i<informationsAuteurs.length; i++) {
%>
<option><%=informationsAuteurs[i]%></option>
<%
} // fin for
%>
</select>
<input type="submit" name="envoyerBtn" value="Envoyer"/></p>
</form>
<%
// si l'utilisateur a tapé la touche Envoyer
if (request.getParameter("envoyerBtn")!=null) {
// On aura les informations de l'auteur
String informationAuteurs = request.getParameter("mnuAuteurs");
// Trouver la liste des livres ecrits par cet auteur
List<Livre> listeLivres = dao.getListeLivresAuteurs(informationAuteurs);
// S’il n’y a pas de livres
if (listeLivres.size()==0)
out.println("Il n’a pas de livres écrits par "+informationAuteurs);
else {
// visualiser la liste des livres de cet auteur
for (Livre l : listeLivres)
out.println(l.getIsbn()+" | "+l.getTitre()+" | "+l.getAuteurs().getInformation()
+"<br/>");
} // fin if
} // fin if request
// Fermeture de la base de données
dao.close();
%>
</body>
</html>