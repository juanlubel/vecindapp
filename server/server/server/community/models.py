from django.db import models
from ..profiles.models import Propietario


class Community(models.Model):
    INSTALLATIONS_CHOICES = (
        ('Piscina', 'Piscina'),
        ('Parking', 'Parking'),
        ('Trasteros', 'Trasteros'),
        ('Jardin', 'Jardin'),
        ('Parque', 'Parque')
    )
    name = models.CharField(max_length=50, default='', null=True, blank=True)
    instalaciones = models.CharField(max_length=50, default='', null=True, blank=True, choices=INSTALLATIONS_CHOICES)
    direccion = models.OneToOneField(
        'community.Direction', on_delete=models.CASCADE
    )
    services = models.ManyToManyField(
        'profiles.Servicio', related_name='employed', blank=True
    )
    president = models.ForeignKey(
        'profiles.Propietario', on_delete=models.CASCADE, related_name='president', null=True, blank=True
    )

    def __str__(self):
        return self.slug

    @property
    def slug(self):
        return \
            self.direccion.avenida + ' ' + \
            str(self.direccion.numero) + ' ' + \
            str(self.direccion.codigoPostal)


class Apartment(models.Model):
    community = models.ForeignKey(
        Community, on_delete=models.CASCADE, related_name='apartments'
    )
    owner = models.ForeignKey(
        Propietario, on_delete=models.CASCADE, related_name='owner', null=True
    )
    renter = models.ManyToManyField(
        'profiles.Inquilino', related_name='renter', blank=True
    )
    piso = models.IntegerField()
    puerta = models.CharField(max_length=5)
    escalera = models.CharField(max_length=25, blank=True)
    numTrastero = models.CharField(max_length=25, blank=True)
    numCochera = models.CharField(max_length=25, blank=True)

    def __str__(self):
        return self.slug

    @property
    def slug(self):
        return \
            self.community.direccion.avenida + ' n' + \
            str(self.community.direccion.numero) + ' p' + \
            str(self.piso) + ' pta' + \
            self.puerta


class Direction(models.Model):
    VIA_CHOICES = (
        ('Avda', 'Avenida'),
        ('C', 'Calle'),
        ('Plz', 'Plaza'),
        ('Ps', 'Paseo')
    )
    via = models.CharField(max_length=5, choices=VIA_CHOICES, default='', blank=True)
    avenida = models.CharField(max_length=50)
    numero = models.IntegerField()
    portal = models.CharField(max_length=5, blank=True)
    codigoPostal = models.IntegerField()
    poblacion = models.CharField(max_length=50)
    provincia = models.CharField(max_length=50)

    def __str__(self):
        return \
            self.via + ' ' + \
            self.avenida + ' ' + \
            str(self.numero) + \
            self.portal
