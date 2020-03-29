function printversion () {
    var prtContent = document.getElementById("opskrift");
    var WinPrint = window.open('', '', 'left=0,top=0,width=800,height=900,toolbar=0,scrollbars=0,status=0');
    WinPrint.document.write('<h1>{{recipe.name}}</h1>');
    WinPrint.document.write('<img src=\"{{recipe.image | absolute_url}}\" alt=\"{{recipe.image | relative_url}}\" width=\"50%\">');
    
    WinPrint.document.write(prtContent.innerHTML);
    WinPrint.document.close();
    WinPrint.focus();
    WinPrint.print();
}