# Securing clusters

You might need to manually create and manage the access control on your
cluster. To do this, you must configure *authentication* service
requirements for Red Hat Advanced Cluster Management for Kubernetes to
onboard workloads to Identity and Access Management (IAM).

Use the role-based access control and authentication to identify the
user associated roles and cluster credentials. To create and manage your
cluster credentials, access the credentials by going to the Kubernetes
secrets where they are stored. See the following documentation for
information about access and credentials:

**Required access:** Cluster administrator

## Role-based access control

Red Hat Advanced Cluster Management for Kubernetes supports role-based
access control (RBAC). Your role determines the actions that you can
perform. RBAC is based on the authorization mechanisms in Kubernetes,
similar to Red Hat OpenShift Container Platform. For more information
about RBAC, see the OpenShift *RBAC* overview in the OpenShift Container
Platform documentation.

**Note:** Action buttons are disabled from the console if the user-role
access is impermissible.

### Overview of roles

Some product resources are cluster-wide and some are namespace-scoped.
You must apply cluster role bindings and namespace role bindings to your
users for consistent access controls. View the table list of the
following role definitions that are supported in Red Hat Advanced
Cluster Management for Kubernetes:

- Role - Definition

- cluster-admin - This is an OpenShift Container Platform default role.
  A user with cluster binding to the cluster-admin role is an OpenShift
  Container Platform super user, who has all access.

- open-cluster-management:cluster-manager-admin - A user with cluster
  binding to the open-cluster-management:cluster-manager-admin role is a
  Red Hat Advanced Cluster Management for Kubernetes super user, who has
  all access. This role allows the user to create a ManagedCluster
  resource.

- open-cluster-management:admin:\<managed_cluster_name\> - A user with
  cluster binding to the
  open-cluster-management:admin:\<managed_cluster_name\> role has
  administrator access to the ManagedCluster resource named,
  \<managed_cluster_name\>. When a user has a managed cluster, this role
  is automatically created.

- open-cluster-management:view:\<managed_cluster_name\> - A user with
  cluster binding to the
  open-cluster-management:view:\<managed_cluster_name\> role has view
  access to the ManagedCluster resource named, \<managed_cluster_name\>.

- open-cluster-management:managedclusterset:admin:\<managed_clusterset_name\> -
  A user with cluster binding to the
  open-cluster-management:managedclusterset:admin:\<managed_clusterset_name\>
  role has administrator access to ManagedCluster resource named
  \<managed_clusterset_name\>. The user also has administrator access to
  managedcluster.cluster.open-cluster-management.io,
  clusterclaim.hive.openshift.io, clusterdeployment.hive.openshift.io,
  and clusterpool.hive.openshift.io resources, which has the managed
  cluster set label:
  cluster.open-cluster-management.io/clusterset=\<managed_clusterset_name\>.
  A role binding is automatically generated when you are using a cluster
  set. See Creating a ManagedClusterSet to learn how to manage the
  resource.

- open-cluster-management:managedclusterset:view:\<managed_clusterset_name\> -
  A user with cluster binding to the
  open-cluster-management:managedclusterset:view:\<managed_clusterset_name\>
  role has view access to the ManagedCluster resource named,
  \<managed_clusterset_name\>\`. The user also has view access to
  managedcluster.cluster.open-cluster-management.io,
  clusterclaim.hive.openshift.io, clusterdeployment.hive.openshift.io,
  and clusterpool.hive.openshift.io resources, which has the managed
  cluster set labels: cluster.open-cluster-management.io,
  clusterset=\<managed_clusterset_name\>. For more details on how to
  manage managed cluster set resources, see Creating a
  ManagedClusterSet.

- open-cluster-management:subscription-admin - A user with the
  open-cluster-management:subscription-admin role can create Git
  subscriptions that deploy resources to multiple namespaces. The
  resources are specified in Kubernetes resource YAML files in the
  subscribed Git repository. Note: When a non-subscription-admin user
  creates a subscription, all resources are deployed into the
  subscription namespace regardless of specified namespaces in the
  resources. For more information, see the Application lifecycle RBAC
  section.

- admin, edit, view - Admin, edit, and view are OpenShift Container
  Platform default roles. A user with a namespace-scoped binding to
  these roles has access to open-cluster-management resources in a
  specific namespace, while cluster-wide binding to the same roles gives
  access to all of the open-cluster-management resources cluster-wide.

- open-cluster-management:managedclusterset:bind:\<managed_clusterset_name\> -
  A user with the
  open-cluster-management:managedclusterset:bind:\<managed_clusterset_name\>
  role has view access to the managed cluster resource called
  \<managed_clusterset_name\>. The user can bind
  \<managed_clusterset_name\> to a namespace. The user also has view
  access to managedcluster.cluster.open-cluster-management.io,
  clusterclaim.hive.openshift.io, clusterdeployment.hive.openshift.io,
  and clusterpool.hive.openshift.io resources, which have the following
  managed cluster set label:
  cluster.open-cluster-management.io/clusterset=\<managed_clusterset_name\>.
  See Creating a ManagedClusterSet to learn how to manage the resource.

**Important:**

- Any user can create projects from OpenShift Container Platform, which
  gives administrator role permissions for the namespace.

- If a user does not have role access to a cluster, the cluster name is
  not displayed. The cluster name might be displayed with the following
  symbol: `-`.

### Console and API RBAC tables

To understand the role-based access control of the components, view the
following console and API RBAC tables:

- Resource: Application - Admin: create, read, update, delete - Edit:
  create, read, update, delete - View: read

- Resource: Channel - Admin: create, read, update, delete - Edit:
  create, read, update, delete - View: read

- Resource: Subscription - Admin: create, read, update, delete - Edit:
  create, read, update, delete - View: read

<!-- -->

- API: applications.app.k8s.io - Admin: create, read, update, delete -
  Edit: create, read, update, delete - View: read

- API: channels.apps.open-cluster-management.io - Admin: create, read,
  update, delete - Edit: create, read, update, delete - View: read

- API: deployables.apps.open-cluster-management.io (Deprecated) - Admin:
  create, read, update, delete - Edit: create, read, update, delete -
  View: read

- API: helmreleases.apps.open-cluster-management.io - Admin: create,
  read, update, delete - Edit: create, read, update, delete - View: read

- API: placements.apps.open-cluster-management.io - Admin: create, read,
  update, delete - Edit: create, read, update, delete - View: read

- API: placementrules.apps.open-cluster-management.io (Deprecated) -
  Admin: create, read, update, delete - Edit: create, read, update,
  delete - View: read

- API: subscriptions.apps.open-cluster-management.io - Admin: create,
  read, update, delete - Edit: create, read, update, delete - View: read

- API: configmaps - Admin: create, read, update, delete - Edit: create,
  read, update, delete - View: read

- API: secrets - Admin: create, read, update, delete - Edit: create,
  read, update, delete - View: read

- API: namespaces - Admin: create, read, update, delete - Edit: create,
  read, update, delete - View: read

<!-- -->

- Resource: Policies - Admin: create, read, update, delete - Edit: read,
  update - View: read

- Resource: PlacementBindings - Admin: create, read, update, delete -
  Edit: read, update - View: read

- Resource: Placements - Admin: create, read, update, delete - Edit:
  read, update - View: read

- Resource: PlacementRules (deprecated) - Admin: create, read, update,
  delete - Edit: read, update - View: read

- Resource: PolicyAutomations - Admin: create, read, update, delete -
  Edit: read, update - View: read

<!-- -->

- API: policies.policy.open-cluster-management.io - Admin: create, read,
  update, delete - Edit: read, update - View: read

- API: placementbindings.policy.open-cluster-management.io - Admin:
  create, read, update, delete - Edit: read, update - View: read

- API: policyautomations.policy.open-cluster-management.io - Admin:
  create, read, update, delete - Edit: read, update - View: read

<!-- -->

- API - Admin - Edit - View

- multiclusterobservabilities.observability.open-cluster-management.io -
  create, read, update, and delete - read, update - read

- searchcustomizations.search.open-cluster-management.io - create, get,
  list, watch, update, delete, patch - - - -

- policyreports.wgpolicyk8s.io - get, list, watch - get, list, watch -
  get, list, watch

<!-- -->

- Role - Role description

- kubevirt.io:view - Only view all Red Hat OpenShift Virtualization
  resources in your cluster.

- kubevirt.io:edit - Create, view, edit, and delete Red Hat OpenShift
  Virtualization resources in your cluster.

- kubevirt.io:admin - Create, view, edit, and delete resources for Red
  Hat OpenShift Virtualization. You can also access the HyperConverged
  custom resource in the openshift-cnv namespace.

- kubevirt.io-acm-managed:admin - An extension of the default
  kubevirt.io roles, granting virtual machine administrators to view,
  edit, and delete virtual machine related resources. Troubleshoot
  issues and complete advanced configuration and administrative tasks.

- kubevirt.io-acm-managed:view - An extension of the default kubevirt.io
  roles, granting extra view-only privileges for virtual machine
  resources on your managed cluster. Monitor virtual machine operations,
  view configurations, and verify the status of virtual machine
  resources without making any changes.

- kubevirt.io-acm-hub:admin - Grants administrator privileges for
  virtual machine migrations across clusters. Grants prerequisite
  permissions to view virtual machines in the multicluster Red Hat
  OpenShift Virtualization console from your hub cluster.

- kubevirt.io-acm-hub:view - Grants view only privileges for virtual
  machine migrations across clusters. Grants prerequisite permissions to
  view virtual machines in the multicluster Red Hat OpenShift
  Virtualization console from your hub cluster.

## Implementing role-based access control

Red Hat Advanced Cluster Management for Kubernetes role-based access
control (RBAC) helps you to validate roles at the console level and at
the API level. You can enable or disable actions in the console based on
user access role permissions.

The multicluster engine operator is a prerequisite and the cluster
lifecycle function of Red Hat Advanced Cluster Management. To manage
RBAC for clusters with the multicluster engine operator, use the RBAC
guidance from the cluster lifecycle multicluster engine for Kubernetes
operator Role-based access control documentation.

### Enabling RBAC for cluster management

For cluster management actions, you need access to your managed cluster
and your hub cluster. If you want to create multiple cluster role
bindings, you can use the `clusterRoleBindings` field to create multiple
cluster role bindings in a single `ClusterPermission` resource.

Complete the following step to create a `ClusterPermission` resource for
creating multiple cluster role bindings:

1.  To create a `ClusterPermission` resource to have many cluster role
    bindings, run the following command:

    ``` bash
    oc create clusterpermission clusterpermission-multiple-clusterrolebindings -n <cluster-name>
    ```

    Your resource might resemble the following YAML with the specified
    `clusterRoleBindings` field:

    ``` yaml
    apiVersion: rbac.open-cluster-management.io/v1alpha1
    kind: ClusterPermission
    metadata:
      name: clusterpermission-multiple-clusterrolebindings
    spec:
      clusterRoleBindings:
        - name: multi-crb-binding1
          roleRef:
            apiGroup: rbac.authorization.k8s.io
            kind: ClusterRole
            name: argocd-application-controller-1
          subject:
            kind: User
            name: user1
        - name: multi-crb-binding2
          roleRef:
            apiGroup: rbac.authorization.k8s.io
            kind: ClusterRole
            name: argocd-application-controller-3
          subjects:
            - kind: User
              name: user2
            - kind: Group
              name: group1
    ```

### Enabling RBAC for Application lifecycle

When you create an application, the `subscription` namespace is created,
then the configuration map is created within the `subscription`
namespace. You must also have access to the `channel` namespace. When
you want to apply a subscription, you must be a subscription
administrator. For more information about managing applications, see
Creating an allow and deny list as subscription administrator.

View the following application lifecycle RBAC operations:

- Create and administer applications on all managed clusters with a user
  named `username`. You must create a cluster role binding and bind it
  to `username`. Run the following command:

  ``` bash
  oc create clusterrolebinding <role-binding-name> --clusterrole=open-cluster-management:cluster-manager-admin --user=<username>
  ```

  This role assigns superuser access to all resources and actions. As a
  superuser, you can create the namespace for the application and all
  application resources in the namespace with this role.

- Create applications that deploy resources to multiple namespaces. You
  must create a cluster role binding to the
  `open-cluster-management:subscription-admin` cluster role, and bind it
  to a user named `username`. Run the following command:

  ``` bash
  oc create clusterrolebinding <role-binding-name> --clusterrole=open-cluster-management:subscription-admin --user=<username>
  ```

- Create and administer applications in the `cluster-name` managed
  cluster, with the `username` user. You must create a cluster role
  binding to the `open-cluster-management:admin:<cluster-name>` cluster
  role and bind it to `username` by entering the following command:

  ``` bash
  oc create clusterrolebinding <role-binding-name> --clusterrole=open-cluster-management:admin:<cluster-name> --user=<username>
  ```

  This role has read and write access to all `application` resources on
  the managed cluster, `cluster-name`. Repeat this if access for other
  managed clusters is required.

- Create a namespace role binding to the `application` namespace using
  the `admin` role and bind it to `username` by entering the following
  command:

  ``` bash
  oc create rolebinding <role-binding-name> -n <application-namespace> --clusterrole=admin --user=<username>
  ```

  This role has read and write access to all `application` resources in
  the `application` namspace. Repeat this if access for other
  applications is required or if the application deploys to multiple
  namespaces.

- You can create applications that deploy resources to multiple
  namespaces. Create a cluster role binding to the
  `open-cluster-management:subscription-admin` cluster role and bind it
  to `username` by entering the following command:

  ``` bash
  oc create clusterrolebinding <role-binding-name> --clusterrole=open-cluster-management:subscription-admin --user=<username>
  ```

- To view an application on a managed cluster named `cluster-name` with
  the user named `username`, create a cluster role binding to the
  `open-cluster-management:view:` cluster role and bind it to
  `username`. Enter the following command:

  ``` bash
  oc create clusterrolebinding <role-binding-name> --clusterrole=open-cluster-management:view:<cluster-name> --user=<username>
  ```

  This role has read access to all `application` resources on the
  managed cluster, `cluster-name`. Repeat this if access for other
  managed clusters is required.

- Create a namespace role binding to the `application` namespace using
  the `view` role and bind it to `username`. Enter the following
  command:

  ``` bash
  oc create rolebinding <role-binding-name> -n <application-namespace> --clusterrole=view --user=<username>
  ```

  This role has read access to all `application` resources in the
  `application` namspace. Repeat this if access for other applications
  is required.

### Enabling RBAC for Governance

For Governance actions, you need access to the namespace where the
policy is created, along with access to the managed cluster where the
policy is applied. The managed cluster must also be part of a
`ManagedClusterSet` that is bound to the namespace. To continue to learn
about `ManagedClusterSet`, see ManagedClusterSets Introduction.

After you select a namespace, such as `rhacm-policies`, with one or more
bound `ManagedClusterSets`, and after you have access to create
`Placement` objects in the namespace, view the following operations:

- To create a `ClusterRole` named `rhacm-edit-policy` with `Policy`,
  `PlacementBinding`, and `PolicyAutomation` edit access, run the
  following command:

  ``` bash
  oc create clusterrole rhacm-edit-policy --resource=policies.policy.open-cluster-management.io,placementbindings.policy.open-cluster-management.io,policyautomations.policy.open-cluster-management.io,policysets.policy.open-cluster-management.io --verb=create,delete,get,list,patch,update,watch
  ```

- To create a policy in the `rhacm-policies` namespace, create a
  namespace `RoleBinding`, such as `rhacm-edit-policy`, to the
  `rhacm-policies` namespace using the `ClusterRole` created previously.
  Run the following command:

  ``` bash
  oc create rolebinding rhacm-edit-policy -n rhacm-policies --clusterrole=rhacm-edit-policy --user=<username>
  ```

- To view policy status of a managed cluster, you need permission to
  view policies in the managed cluster namespace on the hub cluster. If
  you do not have `view` access, such as through the OpenShift `view`
  `ClusterRole`, create a `ClusterRole`, such as `rhacm-view-policy`,
  with view access to policies with the following command:

  ``` bash
  oc create clusterrole rhacm-view-policy --resource=policies.policy.open-cluster-management.io --verb=get,list,watch
  ```

- To bind the new `ClusterRole` to the managed cluster namespace, run
  the following command to create a namespace `RoleBinding`:

  ``` bash
  oc create rolebinding rhacm-view-policy -n <cluster name> --clusterrole=rhacm-view-policy --user=<username>
  ```

### Enabling RBAC for Observability

To view the observability metrics for a managed cluster, you must have
`view` access to that managed cluster on the hub cluster. View the
following list of observability features:

- Access managed cluster metrics.

  Users are denied access to managed cluster metrics, if they are not
  assigned to the `view` role for the managed cluster on the hub
  cluster. Run the following command to verify if a user has the
  authority to create a `managedClusterView` role in the managed cluster
  namespace:

  ``` bash
  oc auth can-i create ManagedClusterView -n <managedClusterName> --as=<user>
  ```

  As a cluster administrator, create a `managedClusterView` role in the
  managed cluster namespace. Run the following command:

  ``` bash
  oc create role create-managedclusterview --verb=create --resource=managedclusterviews -n <managedClusterName>
  ```

  Then apply and bind the role to a user by creating a role bind. Run
  the following command:

  ``` bash
  oc create rolebinding user-create-managedclusterview-binding --role=create-managedclusterview --user=<user>  -n <managedClusterName>
  ```

- Search for resources.

  To verify if a user has access to resource types, use the following
  command:

  ``` bash
  oc auth can-i list <resource-type> -n <namespace> --as=<rbac-user>
  ```

  **Note:** `<resource-type>` must be plural.

- To view observability data in Grafana, you must have a `RoleBinding`
  resource in the same namespace of the managed cluster.

  View the following `RoleBinding` example:

  ``` yaml
  kind: RoleBinding
  apiVersion: rbac.authorization.k8s.io/v1
  metadata:
   name: <replace-with-name-of-rolebinding>
   namespace: <replace-with-name-of-managedcluster-namespace>
  subjects:
   - kind: <replace with User|Group|ServiceAccount>
     apiGroup: rbac.authorization.k8s.io
     name: <replace with name of User|Group|ServiceAccount>
  roleRef:
   apiGroup: rbac.authorization.k8s.io
   kind: ClusterRole
   name: view
  ```

See Role binding policy for more information. See Observability advanced
configuration to configure observability.

## Fine-grained RBAC roles and descriptions

Red Hat Advanced Cluster Management provides specialized roles for
managing virtual machines across clusters, which extend the standard
virtualization capabilities to provide specific access levels within the
fleet virtualization interface.

The following table describes the fine-grained roles that are available
for virtualization management:

- Role name: acm-vm-extended:view - Description: Extends the default
  kubevirt.io roles. Grants permissions to view configurations, status,
  and details for virtual machines in the fleet virtualization console.
  This role also enables read-only troubleshooting.

- Role name: acm-vm-extended:admin - Description: Extends the default
  kubevirt.io roles. Grants administrative permissions to troubleshoot
  and complete configuration tasks for virtual machines in the fleet
  virtualization console.

- Role name: acm-vm-fleet:view - Description: A prerequisite role that
  provides the permissions required to view the fleet virtualization
  console.

- Role name: acm-vm-fleet:admin - Description: A prerequisite role that
  provides the permissions required to view the fleet virtualization
  console and perform cross-cluster live migrations and related
  administrative tasks.

- Role name: acm-vm-cluster-migration:view - Description: Grants the
  permissions required for cross-cluster live migration readiness checks
  between source and destination clusters.

In addition to Red Hat Advanced Cluster Management roles, use the
following standard Red Hat OpenShift Virtualization roles to grant core
virtual machine permissions. These roles are installed automatically
with the virtualization operator:

- `kubevirt.io:view`

- `kubevirt.io:edit`

- `kubevirt.io:admin`

For a complete definition of the permissions granted by each role, see
Default cluster roles for OpenShift Virtualization in the OpenShift
Container Platform documentation.

Use the following scenarios to determine which roles to assign based on
your management requirements:

Scenario one  
Least privilege console visibility

Grant a user or group the minimum permissions required to view virtual
machines in the fleet virtualization console.

- Role: acm-vm-fleet:view - Location: Hub cluster - Binding type:
  ClusterRoleBinding - Purpose: Grants access to view the fleet
  virtualization console.

- Role: kubevirt.io:view - Location: Managed cluster - Binding type:
  RoleBinding - Purpose: Grants read-only access to kubevirt resources.

Scenario two  
Administrative privilege in the fleet virtualization console

Grant a user or group the permissions required to view, troubleshoot,
and manage virtual machine resources in the fleet virtualization
console. See the following table for the roles that are required to
provide administrative privileges in the fleet virtualization console
and the associated permissions for each role:

- Role: acm-vm-fleet:view - Location: Hub cluster - Binding type:
  ClusterRoleBinding - Purpose: Grants access to view the fleet
  virtualization console.

- Role: kubevirt.io:admin - Location: Managed cluster - Binding type:
  RoleBinding - Purpose: Grants administrative access to kubevirt
  resources.

- Role: acm-vm-extended:admin - Location: Managed cluster - Binding
  type: RoleBinding - Purpose: Grants administrative access to extended
  virtual machine resources.

Scenario three  
Cross-cluster live migration

Grant a user or group the permissions that are required to perform live
migrations of virtual machines between clusters. See the following table
for the roles that are required to perform cross-cluster live migrations
and the associated permissions for each role:

- Role: acm-vm-fleet:admin - Location: Hub cluster - Binding type:
  ClusterRoleBinding - Purpose: Grants access to the fleet
  virtualization console and enables live migration tasks.

- Role: kubevirt.io:admin - Location: Source and destination managed
  clusters - Binding type: RoleBinding - Purpose: Grants administrative
  access to kubevirt resources.

- Role: acm-vm-extended:admin - Location: Source and destination managed
  clusters - Binding type: RoleBinding - Purpose: Grants administrative
  access to extended virtual machine resources.

- Role: acm-vm-cluster-migration:view - Location: Source and destination
  managed clusters - Binding type: ClusterRoleBinding - Purpose: Grants
  access for live migration readiness checks.

## Enabling fine-grained role-based access control for virtualization

Enable fine-grained role-based access control for virtualization to
manage and grant permissions to other users at the namespace level and
cluster level on your managed clusters. RBAC for virtualization provides
the capability to grant permissions to a virtual machine namespace
within a cluster without granting permission to the entire managed
cluster.

**Required access:** Cluster administrator

To learn about OpenShift Container Platform default and virtualization
roles and permissions, see Authorization in the OpenShift Container
Platform documentation.

<div class="formalpara">

<div class="title">

Prerequisites

</div>

See the following prerequisites that are needed to enable fine-grained
role-based access control for virtual machines in your environment:

</div>

- Install a supported version of Red Hat OpenShift Virtualization on
  your hub cluster and all managed clusters where you intend to manage
  virtual machines. For more information, see Virtualization -
  Installing.

- **Optional:** Install the migration toolkit for virtualization if you
  plan to perform virtual migrations. See Migrating virtual machines
  between clusters.

- **Note:** If you enable the `cnv-mtv-integrations` feature in Red Hat
  Advanced Cluster Management, the product automatically installs and
  configures both the Red Hat OpenShift Virtualization and migration
  toolkit for virtualization for you.

- Ensure your hub cluster is self-managed as a `local-cluster`, which
  means the `disableHubSelfManagement` parameter is set to `false`, the
  default setting from when you installed Red Hat Advanced Cluster
  Management.

- Configure the Red Hat Advanced Cluster Management hub cluster and all
  managed clusters with the same identities. Users, groups, and group
  memberships must be identical across the environment to ensure that an
  identity authenticated on the hub cluster maps correctly to the same
  identity on the managed clusters.

<div class="formalpara">

<div class="title">

Procedure

</div>

See the following steps to enable the `fine-grained-rbac` component in
the `MultiClusterHub` resource:

</div>

1.  Run the following command to patch the resource. The default name of
    the custom resource is `multiclusterhub`, and
    `open-cluster-management` is the default namespace. If you have a
    different name or namespace, update the command:

``` bash
oc patch mch multiclusterhub -n open-cluster-management --type=json -p='[{"op": "add", "path": "/spec/overrides/components/-", "value": {"name": "fine-grained-rbac", "enabled": true}}]'
```

Next, see Enabling fine-grained role-based access control with the
console for instructions on how to assign roles to users and groups from
the console.

## Fleet Management console role assignment

In Red Hat Advanced Cluster Management, role assignments define how
users interact with your fleet. Understanding the scope of role
assignments is essential for maintaining a secure, multi-tenant
environment. See the following sections for details on the different
role types, granularity scopes, and methods that are available in the
*Fleet Management* console.

Granularity  
Cluster versus project role assignments

Before you create a role assignment, determine the appropriate scope for
the identity. The level of granularity ensures that users have the
necessary permissions without compromising cluster security.

Cluster role assignment  
Grants the identity access to all namespaces within the targeted
clusters or cluster sets. Use this scope for cluster administrators or
infrastructure operators who require global visibility and control.

Project role assignment  
Enforces a strict security boundary by granting access only to specific
projects, which are namespaces within clusters or cluster sets. Use this
scope for application development teams or line-of-business users in a
multi-tenant environment.

Method  
Paths to accessing role assignments

You can manage role assignments through several paths in the console.
The path you choose depends on whether you are managing global
infrastructure or specific application resources.

From the console, navigate to **Fleet Management** in the console to
find one of the following methods:

- Method: Identities - Use case: Use this path to manage role
  assignments for a specific user or group.

- Method: Roles - Use case: Use this path to manage role assignments for
  a specific role.

- Method: Clusters - Use case: Use this path to manage role assignments
  for a specific managed cluster.

- Method: Cluster sets - Use case: Use this path to manage role
  assignments for a logical group of clusters.

**Important:** Role assignments are additive. For example, if a user is
granted a role at the *cluster set* level and a different role at the
*project level*, the user inherits the permissions of both assignments.

## Creating role assignments by using identities in the console

You can manage access permissions for a specific user or group from the
Fleet Management console.

**Required access:** Cluster administrator

<div class="formalpara">

<div class="title">

Prerequisites

</div>

See the following requirements to begin using fine-grained role-based
access control:

</div>

- Enable the fine-grained role-based access control. See Enabling
  fine-grained role-based access control for virtualization for the
  procedure.

- You must be logged in to the OpenShift Container Platform console with
  cluster administrator or hub cluster administrator permissions.

- The target user or group must already exist in the system. If the
  identity is not listed, configure your identity provider before you
  proceed.

**Procedure**

1.  From the navigation menu, expand **User Management** and click
    **Identities**.

2.  Select either the **Users** tab, or the **Groups** tab.

3.  Click the name of the user or group that you want to manage.

4.  Click the **Role Assignments** tab.

5.  Click **Create role assignment**. The configuration window opens
    with the identity information already populated.

6.  In the **Scope** section, define the reach of the permissions by
    selecting one of the following options:

    Global access  
    Applies permissions to all clusters and namespaces in the hub.

    Select cluster set  
    Applies permissions to a specific group of clusters.

    Select clusters  
    Applies permissions to individual managed clusters.

7.  Click **Next**.

8.  If you did not select **Global access**, select the specific cluster
    sets or clusters from the list and click **Next**.

9.  Select the level of granularity for the assignment. See the
    following options:

    Cluster role assignment or Cluster set role assignment  
    Grants access to all namespaces within the selection.

    Project role assignment  
    Limits access to specific common projects, which are namespaces.

10. Click **Next**.

11. If you selected **Project role assignment**, select the target
    projects.

    **Note:** If the required project does not exist, click **Create
    common project** to define a new project. New projects are created
    on each cluster that is selected.

12. Click **Next**.

13. Select the specific role to apply to the identity and click **Next**
    and review the configuration summary for accuracy.

14. Click **Create** to finalize the role assignment.

The new role assignment appears in the **Role Assignments** table for
the selected identity. The permissions take effect the next time the
user logs in or refreshes their session.

## Creating role assignments by using roles in the console

You can assign access permissions to a specific role from the Fleet
Management console.

**Required access:** Cluster administrator

<div class="formalpara">

<div class="title">

Prerequisites

</div>

See the following requirements to begin using fine-grained role-based
access control:

</div>

- Enable the fine-grained role-based access control. See Enabling
  fine-grained role-based access control for virtualization for the
  procedure.

- You must be logged in to the OpenShift Container Platform console with
  cluster administrator or hub cluster administrator permissions.

**Procedure**

1.  From the navigation menu, expand **User Management** and click
    **Roles**.

2.  Click the name of the role that you want to assign to identities.

3.  Click the **Role Assignments** tab.

4.  Click **Create role assignment**. The configuration window opens
    with the role information already populated.

5.  Select the **Identities** \> **Users** or **Groups** that receive
    this role and click **Next**.

6.  In the **Scope** section, define the reach of the permissions by
    selecting one of the following options:

    Global access  
    Applies permissions to all clusters and namespaces in the hub.

    Select cluster set  
    Applies permissions to a specific group of clusters.

    Select clusters  
    Applies permissions to individual managed clusters.

7.  Click **Next**.

8.  If you did not select **Global access**, select the specific cluster
    sets or clusters from the list and click **Next**.

9.  Select the level of granularity for the assignment:

    Cluster role assignment or Cluster set role assignment  
    Grants access to all namespaces within the selection.

    Project role assignment  
    Limits access to specific common projects, which are namespaces.

10. Click **Next**.

11. If you selected **Project role assignment**, select the target
    projects and click **Next** and review the configuration summary for
    accuracy.

12. Click **Create** to finalize the role assignment.

The new role assignment is created. You can verify the assignment by
viewing the **Role Assignments** tab for either the selected role or the
individual identities.

## Creating role assignments by using clusters in the console

You can manage access permissions for a specific managed cluster from
the Fleet Management console.

**Required access:** Cluster administrator

<div class="formalpara">

<div class="title">

Prerequisites

</div>

See the following requirements to begin using fine-grained role-based
access control:

</div>

- Enable the fine-grained role-based access control. See Enabling
  fine-grained role-based access control for virtualization for the
  procedure.

- You must be logged in to the OpenShift Container Platform console with
  cluster administrator or hub cluster administrator permissions.

**Procedure**

1.  From the navigation menu, click **Clusters** to view your cluster
    inventory.

2.  Click the name of the target cluster that you want to manage.

3.  Click the **Role Assignments** tab.

4.  Click **Create role assignment**. The configuration window opens
    with the cluster information pre-filled.

5.  Select the **Identities** \> **Users** or **Groups** that receive
    access to this cluster and click **Next**.

6.  Select the level of granularity for the assignment:

    Cluster role assignment  
    Grants access to all namespaces within this cluster.

    Project role assignment  
    Limits access to specific common projects, which are namespaces.

7.  Click **Next**.

8.  If you selected **Project role assignment**, select the target
    projects and click **Next**.

9.  Select the specific role to grant the identities and click **Next**
    and review the configuration summary for accuracy.

10. Click **Create** to finalize the role assignment.

The new role assignment is created. You can verify the assignment by
viewing the **Role Assignments** tab for either the selected role or the
individual identities.

## Creating role assignments by using cluster sets in the console

You can manage access permissions for a specific cluster set from the
Fleet Management console.

**Required access:** Cluster administrator

<div class="formalpara">

<div class="title">

Prerequisites

</div>

See the following requirements to begin using fine-grained role-based
access control:

</div>

- Enable the fine-grained role-based access control. See Enabling
  fine-grained role-based access control for virtualization for the
  procedure.

- You must be logged in to the OpenShift Container Platform console with
  cluster administrator or hub cluster administrator permissions.

**Procedure**

1.  From the navigation menu, click **Clusters** \> **Cluster Sets** to
    view your cluster set inventory.

2.  Click the name of the target cluster set that you want to manage.

3.  Click the **Role Assignments** tab.

4.  Click **Create role assignment**. The configuration window opens
    with the cluster set information already populated.

5.  Select the **Identities** \> **Users** or **Groups** that receive
    access to this cluster set and click **Next**.

6.  Select the level of granularity for the assignment:

    Cluster set role assignment  
    Grants access to all namespaces within every cluster in the set.

    Project role assignment  
    Limits access to specific common projects, which are namespaces.

7.  Click **Next**.

8.  If you selected **Project role assignment**, select the target
    projects and click **Next**.

9.  Select the specific role to grant the identities and click **Next**.

10. Review the configuration summary for accuracy.

11. Click **Create** to finalize the role assignment.

The new role assignment is created. You can verify the assignment by
viewing the **Role Assignments** tab for either the selected role or the
individual identities.

## Fine-grained role-based access control *MulticlusterRoleAssignment*

The `MulticlusterRoleAssignment` custom resource provides a declarative
method for defining role-based access control (RBAC) across a
multicluster environment. You can use this resource to create a
centralized definition on the hub cluster that specifies which users or
groups receive permissions on targeted managed clusters.

When you apply a `MulticlusterRoleAssignment` resource, the system
creates the corresponding standard Kubernetes RBAC bindings, either a
`RoleBinding` or a `ClusterRoleBinding`, on the selected managed
clusters.

### Resource specification

The resource definition consists of two primary sections: the
**Subject** that receives the permission, and the **Role Assignments**,
which are the permissions that are granted and where they apply.

`spec.subject`  
Defines the identity that is receiving the permissions. See the
following table for information about the subject specification:

- Field: kind - Description: The type of identity is specified.
  Supported values are User or Group.

- Field: name - Description: The name of the user or group is specified,
  for example, jane.doe@example.com or dev-team.

`spec.roleAssignments`  
A list of rules that define the roles to be granted, and the target
clusters. See the following table for information about the role
assignment specification:

- Field: clusterRole - Description: The name of the ClusterRole to
  assign. Note: This role must exist on the managed cluster before the
  assignment.

- Field: clusterSelection - Description: Specifies the target clusters
  for this assignment using standard placement references.

- Field: targetNamespaces - Description: Optional: A list of namespaces
  on the managed cluster where the role applies. This field determines
  the scope of the resulting binding.

### Binding scope

The resulting RBAC resource on the managed cluster depends on whether
you include the `targetNamespaces` field or not:

`RoleBinding`  
A namespace-scoped binding. When you list one or more namespaces in the
`targetNamespaces` field, the system generates a `RoleBinding` within
each of those specific namespaces. The subject receives permissions only
within those namespaces.

`ClusterRoleBinding`  
A cluster-scoped binding: When you do not list a `targetNamespaces`
value or leave it empty, the system generates a `ClusterRoleBinding`.
The subject receives permissions across the entire managed cluster.

`clusterSelection`  
References Red Hat Advanced Cluster Management placement resources to
determine which managed clusters receive the assignment. **Important:**
You must create the placement resource before you create the
`MulticlusterRoleAssignment`. The resource references existing
placements and does not define the placement logic itself.

### Placement examples

The following examples demonstrate how to create different types of role
assignments based on your access control needs, using various placement
methods to select the target clusters.

- Example: `ClusterSet` selection

  The following placement selects all clusters that are members of the
  `cs01` `ManagedClusterSet` specification:

  ``` yaml
  apiVersion: cluster.open-cluster-management.io/v1beta1
  kind: Placement
  metadata:
    name: placement-cs01
    namespace: cs01-bound-namespace
  spec:
    clusterSets:
    - cs01
    tolerations:
    - key: cluster.open-cluster-management.io/unreachable
      operator: Equal
    - key: cluster.open-cluster-management.io/unavailable
      operator: Equal
  ```

- Example: Cluster name selection

The following placement selects specific clusters by name using a label
selector:

``` yaml
apiVersion: cluster.open-cluster-management.io/v1beta1
kind: Placement
metadata:
  name: placement-specific-clusters
  namespace: specific-clusters-namespace
spec:
  predicates:
  - requiredClusterSelector:
      labelSelector:
        matchExpressions:
        - key: name
          operator: In
          values:
          - cluster01
          - cluster02
  tolerations:
  - key: cluster.open-cluster-management.io/unreachable
    operator: Equal
  - key: cluster.open-cluster-management.io/unavailable
    operator: Equal
```

See usage examples in Fine-grained MCA examples.

## *MulticlusterRoleAssignment* examples for fine-grained role-based access control

See examples for the custom resource usage across a multicluster
environment. You can configure various access levels and scopes by using
the `MulticlusterRoleAssignment` resource, as you can see in three
examples: namespace, cluster-wide, and mixed.

### Usage examples

The following examples demonstrate how to create different types of role
assignments based on your access control needs:

- Example one: Namespace-scoped view access

  The following configuration grants the user name, `jane.developer`,
  the `kubevirt.io:view` role. Access is restricted to the `default`
  namespace on clusters that are selected by the `dev-clusters`
  placement:

  ``` yaml
  apiVersion: rbac.open-cluster-management.io/v1beta1
  kind: MulticlusterRoleAssignment
  metadata:
    name: virtualization-view-access
    namespace: dev-virt
  spec:
    subject:
      kind: User
      name: jane.developer
    roleAssignments:
    - name: view-default-namespace
      clusterRole: kubevirt.io:view
      targetNamespaces:
      - default
      clusterSelection:
        type: placements
        placements:
        - name: dev-clusters
          namespace: dev-virt
  ```

- Example two: Cluster-wide administrative access

  The following configuration grants the group name, `virt-admins`, the
  `kubevirt.io:admin` role. Because the `targetNamespaces` value is
  omitted, this example provides administrative access across all
  namespaces on clusters that are selected by the `production-clusters`
  placement:

  ``` yaml
  apiVersion: rbac.open-cluster-management.io/v1beta1
  kind: MulticlusterRoleAssignment
  metadata:
    name: virtualization-admin-global
    namespace: prod-virt
  spec:
    subject:
      kind: Group
      name: virt-admins
    roleAssignments:
    - name: full-admin-access
      clusterRole: kubevirt.io:admin
      clusterSelection:
        type: placements
        placements:
        - name: production-clusters
          namespace: prod-virt
  ```

- Example three: Mixed-scope assignment

  You can define multiple assignments within a single resource to create
  a complex permission profile. The following example grants `test-user`
  subject the `Admin` role on primary clusters and the `Edit` role on
  secondary clusters:

  ``` yaml
  apiVersion: rbac.open-cluster-management.io/v1beta1
  kind: MulticlusterRoleAssignment
  metadata:
    name: mixed-virt-profile
    namespace: virt-workload-01
  spec:
    subject:
      kind: User
      name: test-user
    roleAssignments:
    - name: admin-on-primary
      clusterRole: kubevirt.io:admin
      clusterSelection:
        type: placements
        placements:
        - name: placement-primary
          namespace: virt-primary-namespace
    - name: edit-on-secondary
      clusterRole: kubevirt.io:edit
      clusterSelection:
        type: placements
        placements:
        - name: placement-secondary
          namespace: virt-secondary-namespace
  ```

## Certificates

All certificates that are required by services that run on Red Hat
Advanced Cluster Management are created when you install Red Hat
Advanced Cluster Management. View the following list of certificates,
which are created and managed by the following components of Red Hat
OpenShift Container Platform:

- OpenShift Service Serving Certificates

- Red Hat Advanced Cluster Management webhook controllers

- Kubernetes Certificates API

- OpenShift default ingress

**Required access**: Cluster administrator

**Note:** Users are responsible for certificate rotations and updates.

### Red Hat Advanced Cluster Management hub cluster certificates

OpenShift Container Platform default ingress certificate is a type of
hub cluster certificate. After you install Red Hat Advanced Cluster
Management, Observability certificates are created and used by the
Observability components to give mutual TLS for traffic between the hub
and managed cluster. Access the Observability namespaces to retrieve and
implement the different Observability certificates.

- The following certificates are a part of the
  `open-cluster-management-observability` namespace:

  - `observability-server-ca-certs`: Has the CA certificate to sign
    server-side certificates

  - `observability-client-ca-certs`: Has the CA certificate to sign
    client-side certificates

  - `observability-server-certs`: Has the server certificate used by the
    `observability-observatorium-api` deployment

  - `observability-grafana-certs`: Has the client certificate used by
    the `observability-rbac-query-proxy` deployment

- The `open-cluster-management-addon-observability` namespace includes
  the following certificates on managed clusters:

  - `observability-managed-cluster-certs`: Has the same server CA
    certificate as `observability-server-ca-certs` in the hub server

  - `observability-controller-open-cluster-management.io-observability-signer-client-cert`:
    Has the client certificate used by the
    `metrics-collector-deployment`

The CA certificates are valid for five years and other certificates are
valid for one year. All Observability certificates are automatically
refreshed upon expiration. View the following list to understand the
effects when certificates are automatically renewed:

- Non-CA certificates are renewed automatically when the remaining valid
  time is no more than 73 days. After the certificate is renewed, the
  pods in the related deployments restart automatically to use the
  renewed certificates.

- CA certificates are renewed automatically when the remaining valid
  time is no more than one year. After the certificate is renewed, the
  old CA is not deleted but co-exist with the renewed ones. Both old and
  renewed certificates are used by related deployments, and continue to
  work. The old CA certificates are deleted when they expire.

- When a certificate is renewed, the traffic between the hub cluster and
  managed cluster is not interrupted.

View the following Red Hat Advanced Cluster Management hub cluster
certificates table:

- Namespace: open-cluster-management - Secret name:
  channels-apps-open-cluster-management-webhook-svc-ca - Pod label:
  app=multicluster-operators-channel

- Namespace: open-cluster-management - Secret name:
  channels-apps-open-cluster-management-webhook-svc-signed-ca - Pod
  label: app=multicluster-operators-channel

- Namespace: open-cluster-management - Secret name:
  multicluster-operators-application-svc-ca - Pod label:
  app=multicluster-operators-application

- Namespace: open-cluster-management - Secret name:
  multicluster-operators-application-svc-signed-ca - Pod label:
  app=multicluster-operators-application

- Namespace: open-cluster-management-hub - Secret name:
  registration-webhook-serving-cert signer-secret - Pod label: Not
  required

- Namespace: open-cluster-management-hub - Secret name:
  work-webhook-serving-cert - Pod label: Not required

### Red Hat Advanced Cluster Management managed certificates

Use Red Hat Advanced Cluster Management managed certificates to
authenticate managed clusters within your hub cluster. The following
managed cluster certificates get managed and refreshed automatically.

If you customize the hub cluster API server certificate, the managed
cluster automatically updates its certificates. View the following table
for a summarized list of the component pods that contain Red Hat
Advanced Cluster Management managed certificates and the related
secrets:

- Namespace: open-cluster-management-agent-addon - Secret name (if
  applicable):
  cluster-proxy-open-cluster-management.io-proxy-agent-signer-client-cert

- Namespace: open-cluster-management-agent-addon - Secret name (if
  applicable): cluster-proxy-service-proxy-server-certificates

## Managing certificates

Maintain the security and reliability of your cluster management
environment by managing your certificates. Continue reading to learn how
to refresh, replace, rotate, and list certificates.

### Refreshing a Red Hat Advanced Cluster Management webhook certificate

You can refresh Red Hat Advanced Cluster Management managed
certificates, which are certificates that are created and managed by Red
Hat Advanced Cluster Management services.

Complete the following steps to refresh certificates managed by Red Hat
Advanced Cluster Management:

1.  Delete the secret that is associated with the Red Hat Advanced
    Cluster Management managed certificate, and replace `<namespace>`
    and `<secret>` with the values that you want to use. Run the
    following command:

    ``` bash
    oc delete secret -n <namespace> <secret>
    ```

2.  Restart the services that are associated with the Red Hat Advanced
    Cluster Management managed certificates, and replace `<namespace>`
    and `<pod-label>` with the values for the Red Hat Advanced Cluster
    Management managed cluster certificates. Run the following command:

    ``` bash
    oc delete pod -n <namespace> -l <pod-label>
    ```

    **Note:** If a `pod-label` is not specified, there is no service
    that must be restarted. The secret is recreated and used
    automatically.

### Replacing certificates for *alertmanager* route

If you do not want to use the OpenShift Container Platform default
ingress certificate, replace observability `alertmanager` certificates
by updating the Alertmanager route. Complete the following steps:

1.  Examine the observability certificate with the following command:

    ``` bash
    openssl x509  -noout -text -in ./observability.crt
    ```

2.  Change the common name (`CN`) on the certificate to `alertmanager`.

3.  Change the SAN in the `csr.cnf` configuration file with the hostname
    for your `alertmanager` route.

4.  Create the `alertmanager-byo-ca` Secret resource in the
    `open-cluster-management-observability` namespace by running the
    following command:

    ``` bash
    oc -n open-cluster-management-observability create secret tls alertmanager-byo-ca --cert ./ca.crt --key ./ca.key
    ```

5.  Create the `alertmanager-byo-cert` `Secret` resource in the
    `open-cluster-management-observability` namespace by running the
    following command:

    ``` bash
    oc -n open-cluster-management-observability create secret tls alertmanager-byo-cert --cert ./ingress.crt --key ./ingress.key
    ```

### Rotating the Gatekeeper webhook certificate

Complete the following steps to rotate the Gatekeeper webhook
certificate:

1.  Edit the `Secret` resource that contains the Gatekeeper webhook
    certificate with the following command:

    ``` bash
    oc edit secret -n openshift-gatekeeper-system gatekeeper-webhook-server-cert
    ```

2.  Delete the following content in the `data` section: `ca.crt`,
    `ca.key`, `tls.crt`, and `tls.key`.

3.  Restart the Gatekeeper webhook service by deleting the
    `gatekeeper-controller-manager` pods with the following command:

    ``` bash
    oc delete pod -n openshift-gatekeeper-system -l control-plane=controller-manager
    ```

The Gatekeeper webhook certificate is rotated.

### Verifying certificate rotation

Verify that your certificates are rotated to prevent system outages that
can effect service communication. Complete the following steps:

1.  Identify the `Secret` resource that you want to check.

2.  Check the `tls.crt` key to verify that a certificate is available.

3.  Display the certificate information. Replace `<your-secret-name>`
    with the name of secret that you are verifying. If it is necessary,
    also update the namespace and JSON path. Run the following command:

    ``` bash
    oc get secret <your-secret-name> -n open-cluster-management -o jsonpath='{.data.tls\.crt}' | base64 -d | openssl x509 -text -noout
    ```

4.  Check the `Validity` details in the output. View the following
    `Validity` example:

    ``` bash
    Validity
                Not Before: Jul 13 15:17:50 2023 GMT 
                Not After : Jul 12 15:17:50 2024 GMT 
    ```

    - The `Not Before` value is the date and time that you rotated your
      certificate.

    - The `Not After` value is the date and time for the certificate
      expiration.

### Listing hub cluster managed certificates

You can view a list of hub cluster managed certificates that use
OpenShift Service Serving Certificates service internally. Run the
following command to list the certificates:

``` bash
for ns in multicluster-engine open-cluster-management ; do echo "$ns:" ; oc get secret -n $ns -o custom-columns=Name:.metadata.name,Expiration:.metadata.annotations.service\\.beta\\.openshift\\.io/expiry | grep -v '<none>' ; echo ""; done
```

For more information, see *OpenShift Service Serving Certificates* in
the *Additional resources* section.

**Note:** If observability is enabled, there are additional namespaces
where certificates are created.

## Bringing your own Certificate Authority (CA) certificates for observability

When you install Red Hat Advanced Cluster Management for Kubernetes,
only Certificate Authority (CA) certificates for observability are
provided by default. If you do not want to use the default observability
CA certificates, you can choose to bring your own observability CA
certificates before you enable observability.

<div class="formalpara">

<div class="title">

Prerequisites

</div>

**Required access:** Administrator

</div>

### Customizing your CA certificates for observability

When you choose to bring your own observability CA certificate,
customize it to make it help you with your specific development needs.
Customize your CA certificates for observability with the following
steps:

1.  Generate CA certificates for the server-side and the client-side by
    using OpenSSL commands.

    1.  To generate your CA RSA private keys for the server-side, run
        the following command:

        ``` bash
        openssl genrsa -out serverCAKey.pem 2048
        ```

    2.  To generate your CA RSA private keys for the client-side, run
        the following command:

    ``` bash
    openssl genrsa -out clientCAKey.pem 2048
    ```

2.  Generate the self-signed CA certificates using the private keys.

    1.  To generate the self-signed CA certificates for the server-side,
        run the following command:

        ``` bash
        openssl req -x509 -sha256 -new -nodes -key serverCAKey.pem -days 1825 -out serverCACert.pem
        ```

    2.  To generate the self-signed CA certificates for the client-side,
        run the following command:

    ``` bash
    openssl req -x509 -sha256 -new -nodes -key clientCAKey.pem -days 1825 -out clientCACert.pem
    ```

3.  To store and manage your CA certificates for observability, create
    `Secret` resources for each CA certificate.

    1.  Create the `observability-server-ca-certs` secret by using your
        certificate and private key. Run the following command:

        ``` bash
        oc -n open-cluster-management-observability create secret tls observability-server-ca-certs --cert ./serverCACert.pem --key ./serverCAKey.pem
        ```

    2.  Create the `observability-client-ca-certs` secret by using your
        certificate and private key. Run the following command:

    ``` bash
    oc -n open-cluster-management-observability create secret tls observability-client-ca-certs --cert ./clientCACert.pem --key ./clientCAKey.pem
    ```

### Replacing certificates for *rbac-query-proxy* route

You can replace certificates for the `rbac-query-proxy` route by
creating a Certificate Signing Request (CSR) by using the `csr.cnf`
file.

<div class="formalpara">

<div class="title">

Prerequisites

</div>

Generate CA certifates by using OpenSSL commands. See, Customizing your
CA certificates for observability to create certificates.

</div>

Update the `DNS.1` field in the `subjectAltName` section to match the
host name of the `rbac-query-proxy` route. Complete the following steps:

1.  Retrieve the host name by running the following command:

    ``` bash
    oc get route rbac-query-proxy -n open-cluster-management-observability -o jsonpath="
    {.spec.host}"
    ```

2.  Create a `proxy-byo-ca` secret by using the generated certificates.
    Run the following command:

    ``` bash
    oc -n open-cluster-management-observability create secret tls proxy-byo-ca --cert ./ca.crt --key ./ca.key
    ```

3.  Run the following command to create a `proxy-byo-cert` secret by
    using the generated certificates:

    ``` bash
    oc -n open-cluster-management-observability create secret tls proxy-byo-cert --cert ./ingress.crt --key ./ingress.key
    ```

## Role-based access control for managed clusters with cluster permissions

Manage Kubernetes native resources such as `Roles`, `ClusterRoles`,
`RoleBindings`, and `ClusterRoleBindings` resources across multiple
managed clusters from a by using the cluster permission feature. The
`ClusterPermssion` resource automatically distributes role-based access
control (RBAC) resources to managed clusters and manage the resource
lifecycles.

With the cluster permssions API,
`clusterpermissions.rbac.open-cluster-management.io`, you can specify
the RBAC policies you want to apply to your managed clusters.

### Enabling validation for cluster permissions

Enable the `validate` specification within your `ClusterPermission`
resources to check the existence of your `Role` and `ClusterRole`
resources.

**Required access:** Cluster administrator

Complete the following steps:

1.  Create a `ClusterPermission` resource where you set the `validate`
    specification to `true`.Define the `roleBindings` and
    `clusterRoleBinding` that you want to validate.

    Your YAML file might resemble the following example where you
    configure the `ClusteerRole` to validate the `edit` `ClusterRole`
    for the `sa-sample-existing` `ServiceAccount`, and the `view`
    `ClusterRole` for `Group1`:

    ``` yaml
    apiVersion: rbac.open-cluster-management.io/v1alpha1
    kind: ClusterPermission
    metadata:
      name: clusterpermission-validate-sample
    spec:
      validate: true
      roleBindings:
        - name: default-existing
          namespace: default
          roleRef:
            apiGroup: rbac.authorization.k8s.io
            kind: ClusterRole
            name: edit
          subject:
            namespace: openshift-gitops
            kind: ServiceAccount
            name: sa-sample-existing
      clusterRoleBinding:
          name: crb-cluster1-argo-app-con-3-existing
          roleRef:
            apiGroup: rbac.authorization.k8s.io
            kind: ClusterRole
            name: view
          subject:
            apiGroup: rbac.authorization.k8s.io
            kind: Group
            name: group1
    ```

2.  Apply your `clusterpermission-validate-sample` `ClusterPermission`
    by running the following command:

    ``` bash
    oc apply clusterpermission-validate-sample.yaml
    ```
