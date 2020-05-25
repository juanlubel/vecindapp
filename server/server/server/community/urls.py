from django.conf.urls import url

from .views import (
    CommunityView,
    ApartmentView,
    DirectionsView,
    CommunityCreate,
    ApartmentCreate,
    DirectionCreate,
    CommunityRUD,
    ApartmentRUD,
    DirectionRUD,
    CommunityPresident,
    ApartmentRenter,
    CommunitiesByUser,
    ApartmentsByUser
)

urlpatterns = [
    url(r'^comunidades/$', CommunityView.as_view(), name='List'),
    url(r'^comunidadesByUser/$', CommunitiesByUser.as_view(), name='List'),
    url(r'^comunidad/$', CommunityCreate.as_view(), name='Create'),
    url(r'^comunidad/(?P<pk>[-\d]+)$', CommunityRUD.as_view(), name='Retrieve_Update_Delete'),
    url(r'^comunidad/(?P<pk_c>[-\d]+)/presidente/(?P<pk_p>[-\d]+)$', CommunityPresident.as_view(), name='President'),

    url(r'^viviendas/$', ApartmentView.as_view(), name='List'),
    url(r'^viviendasByUser/$', ApartmentsByUser.as_view(), name='List'),
    url(r'^vivienda/$', ApartmentCreate.as_view(), name='Create'),
    url(r'^vivienda/(?P<pk>[-\d]+)$', ApartmentRUD.as_view(), name='Retrieve_Update_Delete'),
    url(r'^vivienda/(?P<pk_a>[-\d]+)/inquilino/(?P<pk_r>[-\d]+)$', ApartmentRenter.as_view(), name='Renter'),

    url(r'^direcciones/$', DirectionsView.as_view(), name='List'),
    url(r'^direccion/$', DirectionCreate.as_view(), name='Create'),
    url(r'^direccion/(?P<pk>[-\d]+)$', DirectionRUD.as_view(), name='Retrieve_Update_Delete'),
]