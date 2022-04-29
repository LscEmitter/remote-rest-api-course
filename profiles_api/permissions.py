from rest_framework import permissions


class UpdateOwnProfile(permissions.BasePermission):
    """Allow user do edit his own profile"""

    def has_object_permission(self, request, view, obj):
        """Check user is trying to edit their own profile"""
        if request.method in permissions.SAFE_METHODS:
            return True
        print(f"=== request.user.id = {request.user.id}")
        return obj.id == request.user.id


class UpdateOwnStatus(permissions.BasePermission):
    """Allows users ti update their own status"""

    def has_object_permission(self, request, view, obj):
        if request.method in permissions.SAFE_METHODS:
            return True
        return obj.user_profile.id == request.user.id

