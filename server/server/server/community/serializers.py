from rest_framework import serializers
from .models import Community, Direction, Apartment
from ..profiles.serializers import InquilinoSerializer, PropietarioSerializerField, InquilinoSerializerField, \
    PropietarioSerializer


class DirectionSerializer(serializers.ModelSerializer):
    via = serializers.CharField(max_length=10)
    avenida = serializers.CharField(max_length=50)
    numero = serializers.IntegerField()
    portal = serializers.CharField(max_length=5, required=False, allow_blank=True)
    codigoPostal = serializers.IntegerField()
    poblacion = serializers.CharField(max_length=50)
    provincia = serializers.CharField(max_length=50)

    class Meta:
        model = Direction
        fields = (
            'pk',
            'via',
            'avenida',
            'numero',
            'portal',
            'codigoPostal',
            'poblacion',
            'provincia'
        )


class CommunityOnlySerializer(serializers.ModelSerializer):
    slug = serializers.CharField(allow_blank=True, required=False)
    name = serializers.CharField(allow_blank=True, required=False)
    instalaciones = serializers.CharField(required=False, allow_blank=True)
    president = PropietarioSerializerField()

    class Meta:
        model = Community
        fields = ('pk', 'slug', 'instalaciones', 'name', 'president',)


class ApartmentOnlySerializer(serializers.ModelSerializer):
    class Meta:
        model = Apartment
        fields = ('pk', 'slug', 'owner', 'renter')


class ApartmentSerializerField(serializers.RelatedField):
    class Meta:
        model = Apartment
        fields = ('pk', 'slug',)


class ApartmentSerializer(serializers.ModelSerializer):
    community = CommunityOnlySerializer(read_only=True)
    owner = PropietarioSerializerField()
    renter = InquilinoSerializerField(many=True, required=False)
    piso = serializers.IntegerField()
    puerta = serializers.CharField(allow_blank=True)
    escalera = serializers.CharField(allow_blank=True)
    numTrastero = serializers.CharField(allow_blank=True)
    numCochera = serializers.CharField(allow_blank=True)

    class Meta:
        model = Apartment
        fields = ('pk', 'community', 'owner', 'renter', 'piso', 'puerta', 'escalera', 'numTrastero',
                  'numCochera')


class ApartmentRenterSerializer(serializers.ModelSerializer):
    community = CommunityOnlySerializer(read_only=True)
    renter = InquilinoSerializer(many=True)

    class Meta:
        model = Apartment
        fields = ('pk', 'community', 'renter', )


class CommunitySerializer(serializers.ModelSerializer):
    slug = serializers.CharField(allow_blank=True, required=False)
    name = serializers.CharField(allow_blank=True)
    instalaciones = serializers.CharField(required=False, allow_blank=True)
    direccion = DirectionSerializer(read_only=True)
    apartments = ApartmentOnlySerializer(many=True, required=False)
    president = PropietarioSerializerField(required=False, allow_null=True)
    
    class Meta:
        model = Community
        fields = (
            'pk',
            'slug',
            'instalaciones',
            'name',
            'direccion',
            'apartments',
            'president'
        )

    # def get_president(self):


