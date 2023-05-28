CLASS zcl_ecm_005_mustache_test2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: if_oo_adt_classrun.

    TYPES:
      BEGIN OF ty_show_cast,
        castname TYPE string,
        castbday TYPE syst-datum,
      END OF ty_show_cast,

      ty_show_cast_tt TYPE STANDARD TABLE OF ty_show_cast WITH DEFAULT KEY,

      BEGIN OF ty_show,
        showname TYPE string,
        cast     TYPE ty_show_cast_tt,
      END OF ty_show.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_ecm_005_mustache_test2 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lo_mustache TYPE REF TO zcl_mustache,
          lt_data     TYPE STANDARD TABLE OF ty_show,
          lr_data     TYPE REF TO ty_show.

    APPEND INITIAL LINE TO lt_data REFERENCE INTO lr_data.
    lr_data->showname = 'How I Met Your Mother'.
    lr_data->cast     = VALUE ty_show_cast_tt( ( castname = 'Josh Radnor'          castbday = '19740729' )
                                               ( castname = 'Jason Segel'          castbday = '19800118' )
                                               ( castname = 'Neil Patrick Harris'  castbday = '19730615' )
                                               ( castname = 'Allison Lee Hannigan' castbday = '19740324' )
                                               ( castname = 'Cobie Smulders'       castbday = '19820503' )
                                               ( castname = 'Cristin Milioti'      castbday = '19850816' )
     ).

    APPEND INITIAL LINE TO lt_data REFERENCE INTO lr_data.
    lr_data->showname = 'Friends'.
    lr_data->cast     = VALUE ty_show_cast_tt( ( castname = 'Jennifer Aniston'     castbday = '19690211' )
                                               ( castname = 'Lisa Kudrow'          castbday = '19630730' )
                                               ( castname = 'David Schwimmer'      castbday = '19661102' )
                                               ( castname = 'Courteney Cox'        castbday = '19640615' )
                                               ( castname = 'Matthew Perry'        castbday = '19690819' )
                                               ( castname = 'Matt LeBlanc'         castbday = '19670725' )
     ).

    lo_mustache = zcl_mustache=>create(
    'TV Show: {{showname}}'                        && cl_abap_char_utilities=>newline &&
    'Cast:'                                        && cl_abap_char_utilities=>newline &&
    '{{#cast}}'                                    && cl_abap_char_utilities=>newline &&
    '- {{castname}} , Date of Birth: {{castbday+6(2)}}.{{castbday+4(2)}}.{{castbday(4)}}' && cl_abap_char_utilities=>newline &&
    '{{/cast}}'
     ).

    out->write( lo_mustache->render( lt_data ) ).

  ENDMETHOD.

ENDCLASS.
