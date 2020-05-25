from django.shortcuts import get_object_or_404
from rest_framework import generics, viewsets, status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from .serializers import PropietarioSerializer, InquilinoSerializer, ServicioSerializer
from .models import Propietario, Inquilino, Servicio
# Create your views here.


class PropietarioView(generics.ListAPIView):
    serializer_class = PropietarioSerializer
    queryset = Propietario.objects.all()
    permission_classes = [IsAuthenticated]


class PropietarioCreate(APIView):
    serializer_class = PropietarioSerializer
    queryset = Propietario.objects.all()
    permission_classes = [IsAuthenticated]

    def post(self, request):
        print(request.user, request.data)
        serializer_context = {
            'user': request.user,
            'request': request
        }
        serializer_data = request.data.get('propietario', {})

        serializer = self.serializer_class(
            data=serializer_data, context=serializer_context
        )
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(serializer.data, status=status.HTTP_201_CREATED)


class PropietarioRUD(APIView):
    serializer_class = PropietarioSerializer
    queryset = Propietario.objects.all()
    permission_classes = [IsAuthenticated]

    def get(self, request, pk=None):
        queryset = self.queryset
        user = get_object_or_404(queryset, user__pk=pk)
        serializer = PropietarioSerializer(user, many=False)
        return Response(serializer.data)

    def put(self, request, pk=None):
        serializer_context = {'request': request}
        user = get_object_or_404(self.queryset, user__pk=pk)
        serializer_data = request.data.get('propietario', {})
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


class InquilinoView(generics.ListAPIView):
    serializer_class = InquilinoSerializer
    queryset = Inquilino.objects.all()
    permission_classes = [IsAuthenticated]


class InquilinoCreate(APIView):
    serializer_class = InquilinoSerializer
    queryset = Inquilino.objects.all()
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer_context = {
            'user': request.user,
            'request': request
        }
        serializer_data = request.data.get('inquilino', {})

        serializer = self.serializer_class(
            data=serializer_data, context=serializer_context
        )
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(serializer.data, status=status.HTTP_201_CREATED)


class InquilinoRUD(APIView):
    serializer_class = InquilinoSerializer
    queryset = Inquilino.objects.all()
    permission_classes = [IsAuthenticated]

    def get(self, request, pk=None):
        user = get_object_or_404(self.queryset, user__pk=pk)
        serializer = InquilinoSerializer(user, many=False)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def put(self, request, pk=None):
        serializer_context = {'request': request}
        user = get_object_or_404(self.queryset, user__pk=pk)
        serializer_data = request.data.get('inquilino', {})
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


class ServicioView(generics.ListAPIView):
    serializer_class = ServicioSerializer
    queryset = Servicio.objects.all()
    permission_classes = [IsAuthenticated]


class ServicioCreate(APIView):
    serializer_class = ServicioSerializer
    queryset = Servicio.objects.all()
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer_context = {
            'user': request.user,
            'request': request
        }
        serializer_data = request.data.get('inquilino', {})

        serializer = self.serializer_class(
            data=serializer_data, context=serializer_context
        )
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(serializer.data, status=status.HTTP_201_CREATED)


class ServicioRUD(APIView):
    serializer_class = ServicioSerializer
    queryset = Servicio.objects.all()
    permission_classes = [IsAuthenticated]

    def get(self, request, pk=None):
        user = get_object_or_404(self.queryset, user__pk=pk)
        serializer = ServicioSerializer(user, many=False)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def put(self, request, pk=None):
        serializer_context = {'request': request}
        user = get_object_or_404(self.queryset, user__pk=pk)
        serializer_data = request.data.get('servicio', {})
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
