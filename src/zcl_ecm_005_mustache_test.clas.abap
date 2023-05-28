CLASS zcl_ecm_005_mustache_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: if_oo_adt_classrun.

    TYPES:
      BEGIN OF ty_shop_item,
        name  TYPE string,
        price TYPE s_price,
      END OF ty_shop_item,

      ty_shop_item_tt TYPE STANDARD TABLE OF ty_shop_item WITH DEFAULT KEY,

      BEGIN OF ty_shop,
        shop_name TYPE string,
        items     TYPE ty_shop_item_tt,
      END OF ty_shop.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ecm_005_mustache_test IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lo_mustache TYPE REF TO zcl_mustache,
          lt_my_data  TYPE STANDARD TABLE OF ty_shop,
          lr_my_data  TYPE REF TO ty_shop.

    APPEND INITIAL LINE TO lt_my_data REFERENCE INTO lr_my_data.
    lr_my_data->shop_name = 'Rich`s Shop'.
    lr_my_data->items     = VALUE ty_shop_item_tt( ( name = 'Flip Flop'          price = '99.09' )
                                                   ( name = 'Board Shorts'       price = '39.05' )
                                                   ( name = 'Hoodie'             price = '199.00' )
     ).

    APPEND INITIAL LINE TO lt_my_data REFERENCE INTO lr_my_data.
    lr_my_data->shop_name = 'Tom`s Shop'.
    lr_my_data->items     = VALUE ty_shop_item_tt( ( name = 'Disney Hoodie'      price = '89.06' )
                                                   ( name = 'Star Wars T-Shirt'  price = '49.05' )
                                                   ( name = 'Nerdy Tech T-Shirt' price = '79.00' )
     ).

    lo_mustache = zcl_mustache=>create(
    'Welcome to {{shop_name}}!' && cl_abap_char_utilities=>newline &&
    '{{#items}}'                && cl_abap_char_utilities=>newline &&
    '* {{name}} - ${{price}}'   && cl_abap_char_utilities=>newline &&
    '{{/items}}'
     ).

    out->write( lo_mustache->render( lt_my_data ) ).

  ENDMETHOD.

ENDCLASS.
