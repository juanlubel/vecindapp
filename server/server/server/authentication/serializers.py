from rest_framework import serializers
from django.contrib.auth import authenticate
from .models import Profile


class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = ('pk', 'first_name', 'last_name', 'email', 'telephone', 'slug')
        read_only_fields = ['slug']


class UserEmbeddedSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = ('pk', 'slug')


class RegistrationSerializer(serializers.ModelSerializer):
    password = serializers.CharField(
        max_length=128,
        min_length=8,
        write_only=True
    )
    token = serializers.CharField(max_length=255, read_only=True)

    class Meta:
        model = Profile
        fields = ['pk', 'email', 'first_name', 'password', 'token', 'slug']
        read_only_fields = ['slug']

    def create(self, validated_data):
        # Use the `create_user` method we wrote earlier to create a new user.
        return Profile.objects.create_user(**validated_data)


class LoginSerializer(serializers.Serializer):
    # request fields
    email = serializers.CharField(max_length=255)
    password = serializers.CharField(max_length=128, write_only=True)
    # response fields
    token = serializers.CharField(max_length=255, read_only=True)
    pk = serializers.IntegerField(read_only=True)

    class Meta:
        model = Profile
        field = ['email', 'first_name', 'token']

    def validate(self, data):
        email = data.get('email', None)
        password = data.get('password', None)

        if email is None:
            raise serializers.ValidationError(
                'An email address is required to log in.'
            )

        if password is None:
            raise serializers.ValidationError(
                'A password is required to log in.'
            )

        user = authenticate(email=email, password=password)

        if user is None:
            raise serializers.ValidationError(
                'A user with this email and password was not found.'
            )

        if not user.is_active:
            raise serializers.ValidationError(
                'This user has been deactivated.'
            )

        return {
            'email': user.email,
            'pk': user.pk,
            'token': user.token
        }
