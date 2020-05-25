from django.conf.urls import url

from .views import (
    PropietarioView,
    PropietarioCreate,
    PropietarioRUD,
    InquilinoView,
    InquilinoCreate,
    InquilinoRUD,
    ServicioView,
    ServicioRUD,
    ServicioCreate
)

urlpatterns = [
    url(r'^propietarios/$', PropietarioView.as_view(), name='List'),
    url(r'^propietario/(?P<pk>[-\w]+)$', PropietarioRUD.as_view(), name='Retrieve_Update_Delete'),
    url(r'^propietario/$', PropietarioCreate.as_view(), name='Create'),

    url(r'^inquilinos/$', InquilinoView.as_view(), name='List'),
    url(r'^inquilino/(?P<pk>[-\w]+)$', InquilinoRUD.as_view(), name='Retrieve_Update_Delete'),
    url(r'^inquilino/$', InquilinoCreate.as_view(), name='Create'),

    url(r'^servicios/$', ServicioView.as_view(), name='List'),
    url(r'^servicio/(?P<pk>[-\w]+)$', ServicioRUD.as_view(), name='Retrieve_Update_Delete'),
    url(r'^servicio/$', ServicioCreate.as_view(), name='Create'),
]
