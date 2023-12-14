import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:schedule_repository/schedule_repository.dart';
import 'package:turnotron/app_views/schedule_report/model/end_date.dart';
import 'package:turnotron/app_views/schedule_report/model/offices.dart';
import 'package:turnotron/app_views/schedule_report/model/start_date.dart';
import 'package:turnotron/app_views/schedule_report/model/users.dart';
import 'package:universal_html/html.dart' as universal_html;

part 'schedule_report_event.dart';
part 'schedule_report_state.dart';

class ScheduleReportBloc
    extends Bloc<ScheduleReportEvent, ScheduleReportState> {
  ScheduleReportBloc(
    ScheduleRepository scheduleRepository,
  )   : _scheduleRepository = scheduleRepository,
        super(
          ScheduleReportState(
            startDate: StartDate.pure(DateTime.now().copyWith(day: 1)),
            endDate: EndDate.pure(DateTime.now()),
          ),
        ) {
    on<RangeDateChanged>(_onDateRangeChanged);
    on<UserlistChanged>(_onUserlistChanged);
    on<ScheduleReportSubmitted>(_onScheduleReportSubmitted);
    on<OfficelistChanged>(_onOfficelistChanged);
  }

  final ScheduleRepository _scheduleRepository;

  FutureOr<void> _onDateRangeChanged(
    RangeDateChanged event,
    Emitter<ScheduleReportState> emit,
  ) {
    final startDate = StartDate.dirty(event.rangeDate.start);
    final endDate = EndDate.dirty(event.rangeDate.end);
    emit(
      state.copyWith(
        startDate: startDate,
        endDate: endDate,
        isValid: Formz.validate(
          [
            startDate,
            endDate,
            state.userlist,
            state.officelist,
          ],
        ),
      ),
    );
  }

  FutureOr<void> _onUserlistChanged(
    UserlistChanged event,
    Emitter<ScheduleReportState> emit,
  ) {
    final userlist = Userlist.dirty(event.userlist);
    emit(
      state.copyWith(
        userlist: userlist,
        isValid: Formz.validate(
          [
            state.startDate,
            state.endDate,
            userlist,
            state.officelist,
          ],
        ),
      ),
    );
  }

  FutureOr<void> _onOfficelistChanged(
    OfficelistChanged event,
    Emitter<ScheduleReportState> emit,
  ) {
    final officelist = Officelist.dirty(event.officelist);
    const userlist = Userlist.dirty([]);
    emit(
      state.copyWith(
        officelist: officelist,
        userlist: userlist,
        isValid: Formz.validate(
          [
            state.startDate,
            state.endDate,
            userlist,
            officelist,
          ],
        ),
      ),
    );
  }

  FutureOr<void> _onScheduleReportSubmitted(
    ScheduleReportSubmitted event,
    Emitter<ScheduleReportState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.inProgress,
        ),
      );
      final file = await _scheduleRepository.downloadReport(
        from: state.startDate.value,
        to: state.endDate.value,
        users: state.userlist.value,
        includeNonWorkingDays: false,
        includeAbsenceDays: false,
      );
      const dateFormat = 'dd_MM_yyyy';
      final startDateString = DateFormat(dateFormat).format(
        state.startDate.value,
      );
      final endDateString = DateFormat(dateFormat).format(
        state.endDate.value,
      );
      final fileName = 'Report $startDateString - $endDateString.pdf';
      universal_html.AnchorElement(
        href: universal_html.Url.createObjectUrlFromBlob(
          universal_html.Blob(
            <dynamic>[file],
          ),
        ),
      )
        ..download = fileName
        ..click()
        ..remove();
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }
}
