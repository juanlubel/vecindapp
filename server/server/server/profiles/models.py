from django.db import models


class Propietario(models.Model):
    user = models.OneToOneField(
        'authentication.Profile', on_delete=models.CASCADE
    )
    # apartment = models.ManyToManyField(
    #     'community.Apartment', related_name='owner'
    # )
    bankAccount = models.TextField(blank=True)
    isAdmin = models.BooleanField('Administrador', default=False)
    isPresident = models.BooleanField('Presidente', default=False)

    def __str__(self):
        return self.slug

    @property
    def slug(self):
        return self.user.first_name


class Inquilino(models.Model):
    user = models.OneToOneField(
        'authentication.Profile', on_delete=models.CASCADE
    )
    # apartment = models.ForeignKey(
    #     'community.Apartment', on_delete=models.CASCADE, null=True, related_name='leased'
    # )
    bankAccount = models.TextField(blank=True)
    canPublish = models.BooleanField('Puede publicar', default=False)

    def __str__(self):
        return self.slug

    @property
    def slug(self):
        return self.user.first_name


class Servicio(models.Model):
    user = models.OneToOneField(
        'authentication.Profile', on_delete=models.CASCADE
    )
    # community = models.ManyToManyField(
    #     'community.Community', related_name='community'
    # )
    company = models.TextField()
    typeOf = models.TextField()

    def __str__(self):
        return self.slug

    @property
    def slug(self):
        return self.user.first_name
