from django.contrib import admin
from .models import Propietario, Inquilino, Servicio
# Register your models here.

admin.site.register(Propietario)
admin.site.register(Inquilino)
admin.site.register(Servicio)
