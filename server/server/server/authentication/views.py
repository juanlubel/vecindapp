from django.shortcuts import get_object_or_404
from rest_framework import generics
from rest_framework.permissions import AllowAny, IsAuthenticated

from .serializers import ProfileSerializer, RegistrationSerializer, LoginSerializer, UserEmbeddedSerializer
from .models import Profile
from .serializers import ProfileSerializer
from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView
# Create your views here.


class ProfileView(generics.ListCreateAPIView):
    serializer_class = ProfileSerializer
    queryset = Profile.objects.all()


class ProfileRUD(APIView):
    serializer_class = ProfileSerializer
    queryset = Profile.objects.all()
    permission_classes = [IsAuthenticated]

    def get(self, request, pk=None):
        queryset = self.queryset
        user = get_object_or_404(queryset, pk=pk)
        serializer = ProfileSerializer(user, many=False)
        return Response(serializer.data)

    def put(self, request, pk=None):
        serializer_context = {'request': request}
        user = get_object_or_404(self.queryset, pk=pk)
        serializer_data = request.data
        serializer = self.serializer_class(
            user,
            context=serializer_context,
            data=serializer_data,
            partial=True
        )
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)

    def delete(self, request, pk=None):
        user = get_object_or_404(self.queryset, user__pk=pk)
        res = user.delete()
        return Response(res, status=status.HTTP_200_OK)


class IsRegisteredUser(APIView):
    permission_classes = (AllowAny,)
    queryset = Profile.objects.all()
    serializer_class = UserEmbeddedSerializer

    def post(self, request):
        email = request.data.get('email', {})
        queryset = self.queryset
        user = get_object_or_404(queryset, email=email)
        serializer = self.serializer_class(user, many=False)
        return Response(serializer.data)


class ProfileRegister(APIView):
    permission_classes = (AllowAny,)
    serializer_class = RegistrationSerializer

    def post(self, request):
        user = request.data

        serializer = self.serializer_class(data=user)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(serializer.data, status=status.HTTP_201_CREATED)


class ProfileLogin(APIView):
    permission_classes = (AllowAny,)
    serializer_class = LoginSerializer

    def post(self, request):
        user = request.data
        print(user)
        serializer = self.serializer_class(data=user)
        serializer.is_valid(raise_exception=True)
        print(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK)
