sku_by_brand(
  Brand, Type, (SkuId, Price)
  ) :-
    branded_product(BrandedProductId, Brand, _, Type, _),
    sku_product(SkuId, BrandedProductId, _, _, _, Price ).

sku_per_active_ingredient(
  ActiveIngredient, Strength, [_Alergy|_Alergies],
  (Brand, Amount, Price, Format)
  ) :-
    branded_product(BrandedProductId,Brand, ActiveIngredient, Format, _),
    sku_product(_, BrandedProductId, _, Amount, Strength, Price).

foo :-
  findall(Identifier,
    branded_product(Identifier, _Brand, _ActiveIngredient, _Type, Alergens),
     not(contains('alergen_d', Alergens))).

% active_ingredient_without_alergen(ActiveIngredient, ) :-
% findall((Identifier, Brand), (branded_product(Identifier, Brand, _ActiveIngredient, _Type, Alergens), not(contains('alergen_a',Alergens)) ), F).
%
% setof((Identifier, Brand), branded_product(Identifier, Brand, _ActiveIngredient, _Type, Alergens), X).


contains(_, []) :- false,!.
contains(X, [X|_]) :- true, !.
contains(X, [_|Tail]) :- contains(X, Tail).

% included([1,4,5,6], [1,3,6]) :- true.

included([], []) :- false,!.
included([_X], []) :- false,!.
included([], [_]):- false,!.
included([A|B], CandidateList):- contains(A, CandidateList),!,false,
                                 included(B, CandidateList).

% Knowledge Base:
% active_ingredient(name::str, information::str).
active_ingredient(sildenafil, 'you need this for erections and stuff').
active_ingredient(paracetamol, 'you need this for headaches').
active_ingredient(sugar, 'a good placebo').

% active_ingredients_strengths([(active_ingredient::str, strength::int)]).
active_ingredients_strengths([(sildenafil, 50)]).
active_ingredients_strengths([(sildenafil, 100)]).
active_ingredients_strengths([(sildenafil, 150)]).

active_ingredients_strengths([(paracetamol, 250)]).
active_ingredients_strengths([(paracetamol, 500)]).
active_ingredients_strengths([(paracetamol, 1000)]).

% branded_product(id, name, active_ingredient, [alergens]).
branded_product(viagra_tablets, viagra, sildenafil, tablets, ['alergen_a','alergen_b']).
branded_product(viagra_liquid, viagra, sildenafil, liquid, ['alergen_a','alergen_b']).
branded_product(sildehexal_tablets, sildehexal, sildenafil, tablets, ['alergen_a','alergen_d']).

% sku_product(branded_product_id, uuid , amount, strength, price)
sku_product(1, viagra_tablets, 1 , 4, 25, 51.58 ).
sku_product(2, viagra_tablets, 2 , 8, 25, 103.16).
sku_product(3, viagra_tablets, 3 , 4, 50, 56.74).
sku_product(4, viagra_tablets, 4 , 12, 50, 144.46).
sku_product(5, viagra_tablets, 5 , 4, 100, 75.32).
sku_product(6, viagra_tablets, 6 , 12, 100, 185.74).

sku_product(7, sildehexal_tablets, 1 , 4, 25, 14.72).
sku_product(8, sildehexal_tablets, 2 , 12, 25, 22.90).
sku_product(9, sildehexal_tablets, 3 , 24, 25, 33.55).
sku_product(10, sildehexal_tablets, 4 , 4, 50, 16.90).
sku_product(11, sildehexal_tablets, 5 , 12, 50, 26.95).
sku_product(12, sildehexal_tablets, 6 , 24, 50, 44.95).
sku_product(13, sildehexal_tablets, 7 , 4, 100,  21.87).
sku_product(14, sildehexal_tablets, 8 , 12, 100, 44.95).
sku_product(15, sildehexal_tablets, 9 , 24, 100, 69.90).
sku_product(16, sildehexal_tablets, 10 , 48, 100, 89.65).

sku_product(17, viagra_liquid, 1 , 4, 25, 51.58 ).
sku_product(18, viagra_liquid, 2 , 8, 25, 103.16).
sku_product(19, viagra_liquid, 3 , 4, 50, 56.74).
sku_product(20, viagra_liquid, 4 , 12, 50, 144.46).
sku_product(21, viagra_liquid, 5 , 4, 100, 75.32).
sku_product(22, viagra_liquid, 6 , 12, 100, 185.74).
