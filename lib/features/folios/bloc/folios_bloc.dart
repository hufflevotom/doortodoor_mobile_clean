import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'folios_event.dart';
part 'folios_state.dart';

class FoliosBloc extends Bloc<FoliosEvent, FoliosState> {
  FoliosBloc(
    this._foliosRepository,
  ) : super(FoliosInitial()) {
    on<ReportProblem>(_onReportProblem);
    on<FinalizeDelivery>(_onFinalizeDelivery);
    on<FinishDeliveryWithJustification>(_onFinishDeliveryWithJustification);
  }
  final FoliosRepository _foliosRepository;

  Future<void> _onReportProblem(
    ReportProblem event,
    Emitter<FoliosState> emit,
  ) async {
    emit(FoliosLoading());
    try {
      final response = await _foliosRepository.saveReport(
        finality: event.justification,
        idResponsable: event.idResponsable,
        idFolio: event.idFolio,
      );

      if (response) {
        emit(FoliosInitial());
      } else {
        emit(const FoliosError('Error al guardar el reporte'));
      }
    } on SaveReportException catch (e) {
      emit(FoliosError(e.message));
    }
  }

  Future<void> _onFinalizeDelivery(
    FinalizeDelivery event,
    Emitter<FoliosState> emit,
  ) async {
    emit(FoliosLoading());
    try {
      final response = await _foliosRepository.uploadImages(
        imageClient: event.customerPhoto.path,
        imageGuide: event.guidePhoto.path,
        imagePlace: event.photoOfPlace.path,
      );

      final urlClient = response['urlClient'] ?? '';
      final urlGuide = response['urlGuide'] ?? '';
      final urlPlace = response['urlPlace'] ?? '';

      if (urlClient != '' && urlGuide != '' && urlPlace != '') {
        final saveEvidence = await _foliosRepository.saveEvidence(
          urlClient: urlClient,
          urlGuide: urlGuide,
          urlPlace: urlPlace,
          idFolio: event.idFolio,
          idResponsable: event.idResponsable,
          estado: event.estado,
        );
        if (saveEvidence) {
          emit(FoliosInitial());
        } else {
          emit(const FoliosError('Error al guardar la evidencia'));
        }
      } else {
        emit(const FoliosError('Error al guardar las imagenes'));
      }
    } on SaveReportException catch (e) {
      emit(FoliosError(e.message));
    }
  }

  Future<void> _onFinishDeliveryWithJustification(
    FinishDeliveryWithJustification event,
    Emitter<FoliosState> emit,
  ) async {
    emit(FoliosLoading());
    try {
      final response = await _foliosRepository.saveJustification(
        justification: event.justification,
        idFolio: event.idFolio,
        idResponsable: event.idResponsable,
        estado: event.estado,
      );
      if (response) {
        emit(FoliosInitial());
      } else {
        emit(const FoliosError('Error al guardar la justificación'));
      }
    } on SaveJustificationException catch (e) {
      emit(FoliosError(e.message));
    }
  }
}
