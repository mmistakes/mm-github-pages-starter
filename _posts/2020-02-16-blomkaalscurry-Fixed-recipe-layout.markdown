---
layout: recipe
title:  "Blomkålscurry v2"
author: Henrik
date:   2019-11-05 13:39:33 +0100
categories: jekyll update
permalink: /BlomkaalscurryFixed-recipelayout/
excerpt: "Blomkålscurry med kikærter"
teaser: /assets/images/posts/henrik/broed.png
header:
  teaser: /assets/images/posts/henrik/merebroed.jpg
  overlay_image: /assets/images/posts/henrik/broed.png
  overlay_filter: 0.35 # 
  #caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
  actions:
    - label: "Direkte til opskriften"
      url: "/BlomkaalscurryFixed/#opskrift"
recipe:
  servings: 12 cupcakes
  prep: 5 minutes
  cook: 25 minutes
  ingredient_comment: "Jeg laver selv retten uden løg og med [hvidløgs olie][/garlicoil/] for at gøre den lavere på FODMAPs. Den er dog ikke rigtig Low FODMAP da der er både er kikærter og blomkål i."
  ingredients:
    - partname: Cupcakes
      items:  
        - itemname: "2 cups flour"
          prep: "hakket i smadder"
        - itemname:  1/2 cup cocoa powder
        - itemname:  1 tablespoon baking powder
        - itemname:  1 tsp. salt
        - itemname:  1/2 tsp. baking soda
        - itemname:  4 tablespoons butter
        - itemname:  4 oz. applesauce
        - itemname:  1 cup sugar
        - itemname:  2 eggs
        - itemname:  4 oz. chocolate
        - itemname:  1 tsp. vanilla
        - itemname:  1/2 cup whole milk
        - itemname:  1/2 cup boiling water
    - partname: Icing
      items:
        - itemname:  8 oz. of cream cheese
        - itemname:  1 cup of powdered sugar
        - itemname:  1/4 cup milk
        - itemname:  1 tablespoon butter
    - partname: Icing2
      items:
        - itemname:  8 oz. of cream cheese
        - itemname:  1 cup of powdered sugar
        - itemname:  1/4 cup milk
        - itemname:  1 tablespoon butter
    - partname: Icing3
      items:
        - itemname:  8 oz. of cream cheese
        - itemname:  1 cup of powdered sugar
        - itemname:  1/4 cup milk
        - itemname:  1 tablespoon butter
    - partname: Icing4
      items:
        - itemname:  8 oz. of cream cheese
        - itemname:  1 cup of powdered sugar
        - itemname:  1/4 cup milk
        - itemname:  1 tablespoon butter
    - partname: Icing5
      items:
        - itemname:  8 oz. of cream cheese
        - itemname:  1 cup of powdered sugar
        - itemname:  1/4 cup milk
        - itemname:  1 tablespoon butter
  directions:
    - partname: Cupcakes
      directions_markdown: -|
            1. Preheat Oven 350 degree
            2. In a bowl combine flour, cocoa baking powder, baking soda and salt.
            3. In a food processor combine butter and sugar and process until smooth. Add the eggs, 4 oz. of chocolate pieces and vanilla. Add half of the flour mixture and ½ of the milk. Process and add the other half of the flour and the remainder of the milk. Slowly, add the hot water.
            4. Grease and fill muffin tins to top.
            5. Bake 20 25 minutes or until toothpick test comes out clean.
            6. Let cool.
    - partname: Icing
      directions_markdown: -|
        Icing
        1. Combine all of the above in a food processor and process until smooth. Refrigerate.
        2. Frost cupcakes as you use them.
---
{% comment %} create arrays {% endcomment %}
{% assign left_array = "" |split: ',' %}
{% assign right_array = "" |split: ',' %}

{% for part in page.recipe.ingredients %}
    {% assign sizevar = right_array.size | plus: part.items.size  %}
    {% if sizevar > left_array.size  %}
      {% assign left_array = left_array | push: part.partname %}
      {% for item in part.items %}
        {% assign left_array = left_array | push: item %}
      {% endfor %}
     
    {% else %}
        {% assign right_array = right_array | push: part.partname %}
        {% for item in part.items %}
          {% assign right_array = right_array | push: item %}
        {% endfor %}
    {% endif %}
{% endfor %}
<table>
{% for x in left_array %}
<tr>
{% assign y = right_array[forloop.index0] %}
<td style="white-space: nowrap;">{%if x.itemname %}{{x.itemname}}
{%if x.prep %}<br><i>{{x.prep}}</i>{%endif%}
{% else %}<b>{{x}}</b>
{%endif%}</td>
<td width="15%">

</td>
<td style="white-space: nowrap;">
{%if y %}
{%if y.itemname %}{{y.itemname}}
{%if y.prep %}<br><i>{{y.prep}}</i>{%endif%}
{% else %}<b>{{y}}</b>
{%endif%}
{%endif%}
</td>
</tr>
{% endfor %}
</table>
<div style="display: inline-block;">
<div width="49%" style="display: inline-block;">
<ul>
{% for x in left_array %}
{%if x.itemname %}<li>{{x.itemname}}
{%if x.prep %}<br><i>{{x.prep}}</i>{%endif%}</li>
{% else %}<b>{{x}}</b>
{%endif%}
{% endfor %}
</ul>
</div>
<div width="49%" style="display: inline-block;">
<ul>
{% for x in right_array %}
{%if x.itemname %}<li>{{x.itemname}}
{%if x.prep %}<br><i>{{x.prep}}</i>{%endif%}</li>
{% else %}<b>{{x}}</b>
{%endif%}
{% endfor %}
</ul>
</div>
</div>





{{page.recipe.servings}}

{{page.recipe.prep}}

{{page.recipe.cook}}


{% for part in page.recipe.ingredients %}
<div width="49%" style="display: inline-block">
<b>{{part.partname}}</b>
<ul>
{% for item in part.items %}
<li> {{item.itemname}}</li>
{% endfor %}
</ul>
</div>
{% endfor %}




lala
Jeg har det svært med feminas opskrifter! Forstå mig ret, deres rette er virkeligt gode, men deres måde at skrive dem på og layout er fuldstændigt forfærdeligt. Derudover er der også nogle få [principper][principper] der altid gør en ret lidt bedre, som opskrifterne fejler på.

Først det med layoutet... 
Hvordan læser du en opskrift? Jeg sætter mig gerne ned dagen før, læser opskriften igennem og visualisere de ingrediensers vej ned ind i retten og det samlede arbejdsflow fra start til slut. På den måde er der ingen overraskelser og så er der man til tiden. Okay ej... selvfølgeligt gør jeg ikke det! Jeg går i gang fra toppen, helst lidt for sent og prøver at holde styr på Holger mens jeg konstant scroller mellem ingredienslisten og instruktionerne på min telefon og prøver at undgå reklamerne placeret midt i opskriften. Så løber jeg totalt rundt op prøver at finde hoved og hale i hvad det egentligt er jeg laver, indtil retten næsten er færdig og jeg kommer i tanke om at jeg skulle have sat de brune ris over for en halv time siden (det skal opskriften ikke have skylden for, det er bare mig :neutral_face: :blush:). Når maden så er færdig en halv time efter spisetid, så er jeg fuldstændig blæst i hovedet og en lille smule sur på hvem end der har lavet den opskrift (og min kone for at have proppet den på madplanen, men det prøver jeg at vokse fra).

Min pointe er at det er forfatteren til opskriften der skal gøre alt det forarbejde og tage brugeren(siger man det?) i hånden hele vejen igennem. Det er præcis det modsatte Feminas forfatter gør i blomkålcurry [opskriften][opskrift]. Prøv bare at se hvordan selve curryen er beskrevet i en lang paragraf med masser af trin der bare går ud i et... suk! 
Det går måske meget fint, lige indtil man er begyndt at stege krydderierne og man så ser at man skal plukke bladene af korianderplanten og så hakke stilkene. Mast ind mellem "tilsæt salt og peber" og "hæld kokosmælk" står lige rettens allermest tidskrævende trin - Så knækker filmen for mig! 

# Opskrift

## Ingredienser: 






[Cleaned]: /BlomkaalscurryFixed-blog/
[opskrift]: https://www.femina.dk/mad/hovedretter/blomkaalskarry-med-sproede-kikaerter
[principper]:   /principper/
[garlicoil]: /low-foodmap-hvidloegsolie/