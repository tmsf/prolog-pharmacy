% sku_by_brand
% return all the possible solutions to sku and price for a particular brand and
% type
% ex:
% ?- sku_by_brand(viagra, liquid, X).
% X =  (17, 51.58) ;
% X =  (18, 103.16) ;
% X =  (19, 56.74) ;
% X =  (20, 144.46) ;
% X =  (21, 75.32) ;
% X =  (22, 185.74).
sku_by_brand(
  Brand, Type, (SkuId, Price)
  ) :-
    branded_product(BrandedProductId, Brand, _, Type, _),
    sku_product(SkuId, BrandedProductId, _, _, _, Price ).

% sku_per_active_ingredient_without_allergies
% params ActiveIngredient, Strength, Allergies
% return [(Id, Brand, Amount, Price, Format)]
% returns a list sku products that have the right dosage and don't contain
% any allergen listed.
% ex:
% ?- sku_per_active_ingredient_without_allergies(sildenafil, 50, [allergen_d], X).
% X = [(3, viagra, 4, 56.74, tablets),  (4, viagra, 12, 144.46, tablets),  (19, viagra, 4, 56.74, liquid),  (20, viagra, 12, 144.46, liquid)].
sku_per_active_ingredient_without_allergies(
  ActiveIngredient, Strength, Allergies,
  SafeBrandedProductsByStrengthBySku
  ) :-
    active_ingredient_without_allergen(ActiveIngredient, Allergies, SafeBrandedProducts),
    findall(
      (Id, Brand, Amount, Price, Format),
      (
        branded_product(BrandedProductId, Brand, ActiveIngredient, Format, _),
        contains_term((BrandedProductId, Brand), SafeBrandedProducts),
        sku_product(Id, BrandedProductId, _, Amount, Strength, Price)
      ),
      SafeBrandedProductsByStrengthBySku
    ).

% active_ingredient_without_allergen
% params ActiveIngredient, Allergies
% returns [(Identifier, Brand)], of brands with products without any of the Allergies

active_ingredient_without_allergen(ActiveIngredient, Allergies, F) :-
  findall((Identifier, Brand), (branded_product(Identifier, Brand, ActiveIngredient, _Type, Allergens), not_included(Allergies, Allergens) ), F).

% helpers
not_included([], _) :- true,!.
not_included(X, Y) :- intersection(X, Y, []),!.

% included([1,4,5,6], [1,3,6]) :- true.
included(X, Y) :- not(intersection(X, Y, [])).

% Knowledge Base:
% active_ingredient(name::str, information::str).
active_ingredient(sildenafil, 'you need this for erections and stuff').
active_ingredient(paracetamol, 'you need this for headaches').
active_ingredient(sugar, 'a good placebo').

% active_ingredients_strengths([(active_ingredient::str, strength::int)]).
active_ingredients_strengths([(sildenafil, 50)]).
active_ingredients_strengths([(sildenafil, 100)]).
active_ingredients_strengths([(sildenafil, 150)]).

active_ingredients_strengths([(paracetamol, 250), (sugar, 10)]).
active_ingredients_strengths([(paracetamol, 500)]).
active_ingredients_strengths([(paracetamol, 1000)]).

% branded_product(id, name, active_ingredient, [allergens]).
branded_product(viagra_tablets, viagra, sildenafil, tablets, ['allergen_a','allergen_b']).
branded_product(viagra_liquid, viagra, sildenafil, liquid, ['allergen_a','allergen_b']).
branded_product(sildehexal_tablets, sildehexal, sildenafil, tablets, ['allergen_a','allergen_d']).

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
