from rest_framework import serializers

from .models import Propietario, Inquilino, Servicio
from ..authentication.serializers import ProfileSerializer


class PropietarioSerializer(serializers.ModelSerializer):
    user = ProfileSerializer(read_only=True)
    owner = serializers.StringRelatedField(many=True, required=False)
    bankAccount = serializers.CharField(allow_blank=True, required=False)
    isAdmin = serializers.BooleanField(required=False, default=False)
    isPresident = serializers.BooleanField(required=False, default=False)

    class Meta:
        model = Propietario
        fields = ('user', 'isPresident', 'isAdmin', 'bankAccount', 'owner')

    def create(self, validated_data):
        user = self.context.get('user', None)
        prop = Propietario.objects.create(user=user, **validated_data)

        return prop


class PropietarioSerializerField(serializers.RelatedField):
    queryset = Propietario.objects.all()

    def to_representation(self, value):
        print('RELATED FIELD', value)
        user = {"pk": value.user.pk,
                "name": value.user.slug}

        return user


class PropietarioOnlySerializer(serializers.ModelSerializer):
    name = serializers.CharField(allow_blank=True, required=False)

    class Meta:
        model = Propietario
        fields = ('pk', 'name',)


class InquilinoSerializer(serializers.ModelSerializer):
    user = ProfileSerializer(read_only=True)
    renter = serializers.StringRelatedField(many=True, required=False)
    bankAccount = serializers.CharField(allow_blank=True, required=False)
    canPublish = serializers.BooleanField(required=False)

    class Meta:
        model = Inquilino
        fields = ('user', 'canPublish', 'bankAccount', 'renter')

    def create(self, validated_data):
        user = self.context.get('user', None)
        inquilino = Inquilino.objects.create(user=user, **validated_data)

        return inquilino


class InquilinoSerializerField(serializers.RelatedField):
    queryset = Inquilino.objects.all()

    def to_representation(self, value):
        print('RELATED FIELD', value)
        user = {"pk": value.user.pk,
                "name": value.user.slug}
        return user


class ServicioSerializer(serializers.ModelSerializer):
    user = ProfileSerializer(read_only=True)
    employed = serializers.StringRelatedField(many=True)
    # community = serializers.StringRelatedField(many=True)
    company = serializers.CharField()
    typeOf = serializers.CharField()

    class Meta:
        model = Inquilino
        fields = ('user', 'company', 'typeOf', 'employed')

    def create(self, validated_data):
        user = self.context.get('user', None)
        servicio = Servicio.objects.create(user=user, **validated_data)

        return servicio
