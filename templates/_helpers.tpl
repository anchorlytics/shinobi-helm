{{/* vim: set filetype=mustache: */}}

{{- define "tpl.name" -}}
{{-   default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "tpl.fullname" -}}
{{-   if .Values.fullnameOverride -}}
{{-     .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{-   else -}}
{{-     $name := default .Chart.Name .Values.nameOverride -}}
{{-     if contains $name .Release.Name -}}
{{-       .Release.Name | trunc 63 | trimSuffix "-" -}}
{{-     else -}}
{{-       printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{-     end -}}
{{-   end -}}
{{- end -}}

{{- define "tpl.chart" -}}
{{-   printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "tpl.selectorLabels" -}}
app.kubernetes.io/name: {{ include "tpl.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "tpl.labels" -}}
helm.sh/chart: {{ include "tpl.chart" . }}
{{    include "tpl.selectorLabels" . }}
{{-   if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{-   end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

