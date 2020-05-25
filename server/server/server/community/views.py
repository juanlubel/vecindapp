from django.db.models import Q
from django.shortcuts import get_object_or_404
from rest_framework import generics, status
from rest_framework.exceptions import NotFound
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from ..profiles.models import Propietario, Inquilino
from ..profiles.serializers import InquilinoSerializer, PropietarioSerializerField, PropietarioSerializer
from ..authentication.models import Profile
from ..authentication.serializers import ProfileSerializer


from .serializers import CommunitySerializer, ApartmentSerializer, DirectionSerializer, ApartmentRenterSerializer
from .models import Community, Apartment, Direction
# Create your views here.


class CommunityView(generics.ListAPIView):
    serializer_class = CommunitySerializer
    queryset = Community.objects.all()
    permission_classes = [IsAuthenticated]


class ApartmentView(generics.ListAPIView):
    serializer_class = ApartmentSerializer
    queryset = Apartment.objects.all()
    permission_classes = [IsAuthenticated]


class DirectionsView(generics.ListAPIView):
    serializer_class = DirectionSerializer
    queryset = Direction.objects.all()
    permission_classes = [IsAuthenticated]


class CommunityCreate(APIView):
    serializer_class = CommunitySerializer
    queryset = Community.objects.all()
    permission_classes = [IsAuthenticated]

    def post(self, request):
        direction_pk = request.data['comunidad']['direccion']
        try:
            direction = Direction.objects.get(pk=direction_pk)
        except Direction.DoesNotExist:
            raise NotFound('Direction not found.')
        serializer_context = {
            'request': request,
        }
        serializer_data = request.data.get('comunidad', {})
        serializer_data['direccion'] = direction
        serializer = self.serializer_class(
            data=serializer_data, context=serializer_context
        )
        serializer.is_valid(raise_exception=True)
        community = serializer.create(validated_data=serializer_data)

        return Response(CommunitySerializer(community, many=False).data, status=status.HTTP_201_CREATED)


class ApartmentCreate(APIView):
    serializer_class = ApartmentSerializer
    queryset = Apartment.objects.all()
    permission_classes = [IsAuthenticated]

    def post(self, request):
        community_pk = request.data['comunidad']
        try:
            community = Community.objects.get(pk=community_pk)
        except Direction.DoesNotExist:
            raise NotFound('Community not found.')
        print(request.user.id)
        try:
            owner = Propietario.objects.get(user__pk=request.user.id)
        except Propietario.DoesNotExist:
            serializer_context = {
                'request': request,
                'user': Profile.objects.get(pk=request.user.id)
            }
            serializer_data = {

            }
            print(serializer_context)
            serializer = PropietarioSerializer(data=serializer_data, context=serializer_context)
            serializer.is_valid(raise_exception=True)
            owner = serializer.save()
        print(owner)
        serializer_context = {
            'request': request
        }
        serializer_data = request.data.get('vivienda', {})
        serializer_data['community'] = community
        serializer_data['owner'] = owner
        print(serializer_data)
        serializer = self.serializer_class(
            data=serializer_data, context=serializer_context
        )
        # serializer.is_valid(raise_exception=True)
        print(serializer_data)
        apartment = serializer.create(validated_data=serializer_data)

        return Response(ApartmentSerializer(apartment, many=False).data, status=status.HTTP_201_CREATED)


class DirectionCreate(APIView):
    serializer_class = DirectionSerializer
    queryset = Direction.objects.all()
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer_context = {
            'request': request
        }
        serializer_data = request.data.get('direccion', {})
        serializer = self.serializer_class(
            data=serializer_data, context=serializer_context
        )
        serializer.is_valid(raise_exception=True)
        print(serializer_data)
        direcction = serializer.create(validated_data=serializer_data)

        return Response(DirectionSerializer(direcction, many=False).data, status=status.HTTP_201_CREATED)


class CommunitiesByUser(APIView):
    serializer_class = CommunitySerializer
    queryset = Community.objects.all()
    permission_classes = [IsAuthenticated]

    def get(self, request):
        queryset = self.queryset
        print(request.user.pk)
        pk = request.user.pk
        communities = queryset.filter(
            Q(apartments__owner__user__pk=pk) |
            Q(apartments__renter__user__pk=pk)
        )
        communities_list = list(dict.fromkeys(communities))
        serializer = self.serializer_class(communities_list, many=True)
        return Response(serializer.data)


class ApartmentsByUser(APIView):
    serializer_class = ApartmentSerializer
    queryset = Apartment.objects.all()
    permission_classes = [IsAuthenticated]

    def get(self, request):
        queryset = self.queryset
        print(request.user.pk)
        pk = request.user.pk
        apartments = queryset.filter(
            Q(owner__user__pk=pk) |
            Q(renter__user__pk=pk)
        )
        apartments_list = list(dict.fromkeys(apartments))
        serializer = self.serializer_class(apartments_list, many=True)
        return Response(serializer.data)


class CommunityRUD(APIView):
    serializer_class = CommunitySerializer
    queryset = Community.objects.all()
    permission_classes = [IsAuthenticated]

    def get(self, request, pk=None):
        queryset = self.queryset
        community = get_object_or_404(queryset, pk=pk)
        serializer = CommunitySerializer(community, many=False)
        return Response(serializer.data)

    def put(self, request, pk=None):
        serializer_context = {'request': request}
        community = get_object_or_404(self.queryset, pk=pk)
        serializer_data = request.data.get('comunidad', {})
        serializer = self.serializer_class(
            community,
            context=serializer_context,
            data=serializer_data,
            partial=True
        )
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)

    def delete(self, request, pk=None):
        community = get_object_or_404(self.queryset, pk=pk)
        res = community.delete()
        return Response(res, status=status.HTTP_200_OK)


class ApartmentRUD(APIView):
    serializer_class = ApartmentSerializer
    queryset = Apartment.objects.all()
    permission_classes = [IsAuthenticated]

    def get(self, request, pk=None):
        queryset = self.queryset
        community = get_object_or_404(queryset, pk=pk)
        serializer = ApartmentSerializer(community, many=False)
        return Response(serializer.data)

    def put(self, request, pk=None):
        serializer_context = {'request': request}
        community = get_object_or_404(self.queryset, pk=pk)
        serializer_data = request.data.get('vivienda', {})
        serializer = self.serializer_class(
            community,
            context=serializer_context,
            data=serializer_data,
            partial=True
        )
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)

    def delete(self, request, pk=None):
        apartment = get_object_or_404(self.queryset, pk=pk)
        res = apartment.delete()
        return Response(res, status=status.HTTP_200_OK)


class DirectionRUD(APIView):
    serializer_class = DirectionSerializer
    queryset = Direction.objects.all()
    permission_classes = [IsAuthenticated]

    def get(self, request, pk=None):
        queryset = self.queryset
        direction = get_object_or_404(queryset, pk=pk)
        serializer = self.serializer_class(direction)
        return Response(serializer.data)

    def put(self, request, pk=None):
        serializer_context = {'request': request}
        direction = get_object_or_404(self.queryset, pk=pk)
        serializer_data = request.data.get('direccion', {})
        serializer = self.serializer_class(
            direction,
            context=serializer_context,
            data=serializer_data,
            partial=True
        )
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)

    def delete(self, request, pk=None):
        direction = get_object_or_404(self.queryset, pk=pk)
        res = direction.delete()
        return Response(res, status=status.HTTP_200_OK)


class CommunityPresident(APIView):
    serializer_class = CommunitySerializer
    queryset = Community.objects.all()
    permission_classes = [IsAuthenticated]

    def get(self, request, pk_c, pk_p):
        community = get_object_or_404(self.queryset, pk=pk_c)
        try:
            president = Propietario.objects.get(user__pk=pk_p)
        except Propietario.DoesNotExist:
            raise NotFound('This pk is not a Owner instance.')
        print(community.president.user.pk, president.user.pk)
        if community.president.user.pk is not president.user.pk:
            old_president = Propietario.objects.get(user__pk=community.president.user.pk)
            old_president.isPresident = False
            old_president.save()

        president.isPresident = True
        president.save()
        community.president = president
        community.save()

        return Response(CommunitySerializer(community, many=False).data, status=status.HTTP_200_OK)

    def delete(self, request, pk_c, pk_p):
        community = get_object_or_404(self.queryset, pk=pk_c)
        president = Propietario.objects.get(user__pk=pk_p)
        president.isPresident = False
        president.save()
        community.president = None
        community.save()

        return Response(CommunitySerializer(community, many=False).data, status=status.HTTP_200_OK)


class ApartmentRenter(APIView):
    serializer_class = ApartmentRenterSerializer
    queryset = Apartment.objects.all()
    permission_classes = [IsAuthenticated]

    def get(self, request, pk_a, pk_r):
        print('renter', pk_a, pk_r)
        try:
            renter = Inquilino.objects.get(user__pk=pk_r)
        except Exception:
            serializer_context = {
                'request': request,
                'user': Profile.objects.get(pk=pk_r)
            }
            serializer_data = {
                'bankAccount': Propietario.objects.get(user__pk=pk_r).bankAccount
            }
            print(serializer_context)
            serializer = InquilinoSerializer(data=serializer_data, context=serializer_context)
            serializer.is_valid(raise_exception=True)
            renter = serializer.save()

        apartment = get_object_or_404(self.queryset, pk=pk_a)
        apartment.renter.add(renter)
        apartment.save()

        return Response(ApartmentSerializer(apartment, many=False).data, status=status.HTTP_200_OK)